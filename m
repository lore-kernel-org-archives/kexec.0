Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YvMhZ-0003IT-Nn
 for kexec@lists.infradead.org; Thu, 21 May 2015 09:23:42 +0000
Received: by wichy4 with SMTP id hy4so6803145wic.1
 for <kexec@lists.infradead.org>; Thu, 21 May 2015 02:23:18 -0700 (PDT)
Received: from [192.168.0.15] (195-132-118-87.rev.numericable.fr.
 [195.132.118.87])
 by mx.google.com with ESMTPSA id ng5sm1616045wic.24.2015.05.21.02.23.17
 for <kexec@lists.infradead.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 May 2015 02:23:17 -0700 (PDT)
Message-ID: <555DA405.1070002@canonical.com>
Date: Thu, 21 May 2015 11:23:17 +0200
From: Louis Bouchard <louis.bouchard@canonical.com>
MIME-Version: 1.0
Subject: Makedumpfile and kernel support
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hello,

- From time to time, on the distribution side, we get reports that makedumpfile
says the kernel version is not supported with the following message :

"The kernel version is not supported.
The created dumpfile may be incomplete. "

Depending on the kernel and makedumpfile versions, it can be either
disregarded or it requires fixing on the distribution. For instance, with
Kumagai's help, I backported the required commits so makedumpfile on Jessie
(1.5.3) would not complain about Jessie's kernels (3.16).

While we can review each patch to identify those who have specific kernel
requirements, would it be possible to identify a way to highlight those
patches so they become easily identifiable for potential backport ?

Maybe something like "[kernel]" in the git log or specific mention in the
commit log.  I would like to avoid going back to upstream to confirm that the
proper patches are being identified.

Any comments, toughts, concerns ?

Kind regards,

...Louis


- -- 
Louis Bouchard
Software engineer, Cloud & Sustaining eng.
Canonical Ltd
Ubuntu developer                       Debian Maintainer
GPG : 429D 7A3B DD05 B6F8 AF63  B9C4 8B3D 867C 823E 7A61
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJVXaQAAAoJEIs9hnyCPnphYbMP/21fhl1pHNcToYH5c2casXTM
D794dqwGzSSgXNWPueTajW/7OyvEEryN6izUfOUQ3ACJ10c0zzv/GQ6mjrIoKLz8
+xhml3gM0Tu3oJsKz5fHDbkKAx9X8604fQSB5Vrsz23Tr/MaNH2ASV000PE7HvY5
uIupEQMsluVV8EeLtjI1NPGNKwk9ZpwgCK4ogKCD0k3Gqn0JGB/bA6T0dpqjPGkm
At+nDUMNpADYkWd6sm9pem1GqgUJMNjgyu9P/vKxGCd++uUvmXolZT0BXXJhebKg
U8BNCxf/l/dhfXx5++GMMVCtD8Po/oDU2/x3C7MefrTaRlZmHTzEAhWr/BPp3I8J
vPK+emrS8b5WcrWY3eq3dvL1gnW0k8ysppUEntgmXF5u1XlDopyoLeDuCXhjrTz8
+y4OHzp2TxX10hZPP6T60YM64AyRsDzJoU1UTk6WMtDxfvy1MW0ynQ5K8jSQHMnO
1GWEPFF2gXmAmMkWh7KxPbjOvBriJurwo4YDjf7kiu9XWCUzSN/o3QV4ywxYS9Nf
Yf8W/zSiEL6z0pODSuNgFis9t610vKdGLPAS97JX3CA2wn1jSfwP7eCXc81Jf1iJ
+O10J4I5/G04iCOaVk0muEywwfeq5GcXsSj0u/YwCZEP1TzWAEhyEZEzn+k4RQJU
6R88MEn7+Zcuz+gvxXBk
=10mW
-----END PGP SIGNATURE-----

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
