Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UwqOD-00065d-IT
 for kexec@lists.infradead.org; Wed, 10 Jul 2013 09:08:47 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 2D1F83EE081
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2013 18:08:16 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1F99B45DE50
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2013 18:08:16 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0845E45DE4D
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2013 18:08:16 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id EF78E1DB802F
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2013 18:08:15 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id A2FD91DB803B
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2013 18:08:15 +0900 (JST)
Message-ID: <51DD246F.70007@jp.fujitsu.com>
Date: Wed, 10 Jul 2013 18:07:59 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: makedumpfile 1.5.4, 734G kdump tests
References: <20130709162403.GA25441@sgi.com>
 <CAJGZr0JPrBB3cVyVdwJdd6cEUfnXNMuRijb9EOoSy+XmRupv7A@mail.gmail.com>
In-Reply-To: <CAJGZr0JPrBB3cVyVdwJdd6cEUfnXNMuRijb9EOoSy+XmRupv7A@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Maxim Uvarov <muvarov@gmail.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, Cliff Wickman <cpw@sgi.com>

(2013/07/10 17:33), Maxim Uvarov wrote:
> does crash tool read snappy compressed files?
>

Yes, but you need to specify libraries at build.

http://people.redhat.com/anderson/crash.changelog.html

6.0.9    - Fix for building on host machines that have glibc-2.15.90 installed,
<cut>

          - Add support for reading compressed kdump dumpfiles that were
            compressed by the snappy compressor.  This feature is disabled by
            default.  To enable this feature, build the crash utility in the
            following manner:
            (1) Install the snappy libraries by using the host system's package
                manager or by directly downloading libraries from author's
                website.  The packages required are:
                  - snappy
                  - snappy-devel
                The author's website is: http://code.google.com/p/snappy
            (2) Create a CFLAGS.extra file and an LDFLAGS.extra file in top-level
                crash sources directory:
                  - enter -DSNAPPY in the CFLAGS.extra file
                  - enter -lsnappy in the LDFLAGS.extra file.
            (3) Build crash with "make" as always.

6.0.7    - Enhanced the "search" command to allow the searched-for value
<cut>
          - Add support to for reading dumpfiles compressed by LZO using
            makedumpfile version 1.4.4 or later.  This feature is disabled by
            default.  To enable this feature, build the crash utility in the
            following manner:
            (1) Install the LZO libraries by using the host system's package
                manager or by directly downloading libraries from author's
                website.  The packages required are:
                  - lzo
                  - lzo-minilzo
                  - lzo-devel
                The author's website is: http://www.oberhumer.com/opensource/lzo
            (2) Create a CFLAGS.extra file and an LDFLAGS.extra file in top-level
                crash sources directory:
                  - enter -DLZO in the CFLAGS.extra file
                  - enter -llzo2 in the LDFLAGS.extra file.
            (3) Build crash with "make" as always.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
