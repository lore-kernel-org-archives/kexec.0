From: HAGIO KAZUHITO=?unknown-8bit?b?6JCp5bC+IOS4gOS7gQ==?= <k-hagio-ab@nec.com>
Date: Wed, 9 Mar 2022 01:37:35 +0000
Subject: [PATCH v2 1/1] Simplify the generation of man pages
In-Reply-To: <20220304151748.138775-1-artafinde@archlinux.org>
References: <20220304151748.138775-1-artafinde@archlinux.org>
Message-ID: <TYYPR01MB67779881832C65F508E3F99ADD0A9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

-----Original Message-----
> Use `sed` to simplify the man pages generation. Keep the .in files
> intact during make and generate the actual man pages with sed.
> Additionally package tools already gz the man pages during install so it
> doesn't really need to do that during make and it breaks reproducibility
> of the package due to timestamps on files.
> 
> Motivation: https://reproducible-builds.org
> 
> Signed-off-by: Leonidas Spyropoulos <artafinde@archlinux.org>

Thank you for the good improvement!

Applied with adding the man files to .gitignore:
https://github.com/makedumpfile/makedumpfile/commit/2169de66ecd4504a3e69e0be0330f492f966ce5e

(and thank you Guilherme for your review and test.)

Kazu


