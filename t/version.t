#!/usr/bin/env perl

use Test::Most tests => 1;

use Alien::pdf2htmlEX;
use Alien::OpenJPEG;
use Alien::Poppler;
use Alien::FontForge;

use Capture::Tiny qw(capture_merged);

use lib 't/lib';

subtest "Run pdf2htmlEX" => sub {
	use Env qw(@LD_LIBRARY_PATH @DYLD_FALLBACK_LIBRARY_PATH @PATH);
	unshift @LD_LIBRARY_PATH, Alien::FontForge->rpath, Alien::Poppler->rpath;
	unshift @DYLD_FALLBACK_LIBRARY_PATH, Alien::FontForge->rpath, Alien::Poppler->rpath;
	unshift @PATH, Alien::FontForge->rpath, Alien::Poppler->rpath, Alien::OpenJPEG->rpath;

	my $pdf2htmlEX = Alien::pdf2htmlEX->pdf2htmlEX_path;

	my ($merged, $result) = capture_merged {
		system($pdf2htmlEX, qw(--version));
	};

	my $version_match_re = qr/pdf2htmlEX version (?<version>[\d.]+)/;

	like $merged, $version_match_re, 'pdf2htmlEX output has version';

	$merged =~ $version_match_re;
	is $+{version}, Alien::pdf2htmlEX->version, "the version matches what is installed: @{[ Alien::pdf2htmlEX->version ]}";
};

done_testing;
