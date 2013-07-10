Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uwz7I-0004CI-3f
 for kexec@lists.infradead.org; Wed, 10 Jul 2013 18:27:53 +0000
Date: Wed, 10 Jul 2013 13:27:28 -0500
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: makedumpfile 1.5.4, 734G kdump tests
Message-ID: <20130710182728.GA13240@sgi.com>
References: <20130709162403.GA25441@sgi.com>
 <CAJGZr0JPrBB3cVyVdwJdd6cEUfnXNMuRijb9EOoSy+XmRupv7A@mail.gmail.com>
 <51DD246F.70007@jp.fujitsu.com>
 <CAJGZr0L7GBqJHaPzgpFxhpF_jmAZfDJYU_=MFxATxnLk13ni4g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJGZr0L7GBqJHaPzgpFxhpF_jmAZfDJYU_=MFxATxnLk13ni4g@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Maxim Uvarov <muvarov@gmail.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kexec@lists.infradead.org

On Wed, Jul 10, 2013 at 04:37:20PM +0400, Maxim Uvarov wrote:
> thanks. I also have a question about static support of snappy in
> makedumpfile.
> 
> Dynamic linking works ok.  But static link confuses snappy C++ library and
> C, and fails with:
> undefined reference to `__gxx_personality_v0'  and undefined reference to
> new[].
> 
> Is there workaround for that?
> gcc version 4.4.6 20120305 (Red Hat 4.4.6-4) (GCC)

I think you'll have to install the libstdc++ devel rpm, such as
libstdc++-devel-4.4.7-3.el6.x86_64.rpm,  to get libstdc++.a

And probably add -lstdc to the Makefile
   LIBS := -lsnappy -lstdc++ $(LIBS)


> Maxim.
> 
> 2013/7/10 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> 
> > (2013/07/10 17:33), Maxim Uvarov wrote:
> >
> >> does crash tool read snappy compressed files?
> >>
> >>
> > Yes, but you need to specify libraries at build.
> >
> > http://people.redhat.com/**anderson/crash.changelog.html<http://people.redhat.com/anderson/crash.changelog.html>
> >
> > 6.0.9    - Fix for building on host machines that have glibc-2.15.90
> > installed,
> > <cut>
> >
> >          - Add support for reading compressed kdump dumpfiles that were
> >            compressed by the snappy compressor.  This feature is disabled
> > by
> >            default.  To enable this feature, build the crash utility in the
> >            following manner:
> >            (1) Install the snappy libraries by using the host system's
> > package
> >                manager or by directly downloading libraries from author's
> >                website.  The packages required are:
> >                  - snappy
> >                  - snappy-devel
> >                The author's website is: http://code.google.com/p/**snappy<http://code.google.com/p/snappy>
> >            (2) Create a CFLAGS.extra file and an LDFLAGS.extra file in
> > top-level
> >                crash sources directory:
> >                  - enter -DSNAPPY in the CFLAGS.extra file
> >                  - enter -lsnappy in the LDFLAGS.extra file.
> >            (3) Build crash with "make" as always.
> >
> > 6.0.7    - Enhanced the "search" command to allow the searched-for value
> > <cut>
> >          - Add support to for reading dumpfiles compressed by LZO using
> >            makedumpfile version 1.4.4 or later.  This feature is disabled
> > by
> >            default.  To enable this feature, build the crash utility in the
> >            following manner:
> >            (1) Install the LZO libraries by using the host system's package
> >                manager or by directly downloading libraries from author's
> >                website.  The packages required are:
> >                  - lzo
> >                  - lzo-minilzo
> >                  - lzo-devel
> >                The author's website is: http://www.oberhumer.com/**
> > opensource/lzo <http://www.oberhumer.com/opensource/lzo>
> >            (2) Create a CFLAGS.extra file and an LDFLAGS.extra file in
> > top-level
> >                crash sources directory:
> >                  - enter -DLZO in the CFLAGS.extra file
> >                  - enter -llzo2 in the LDFLAGS.extra file.
> >            (3) Build crash with "make" as always.
> >
> > --
> > Thanks.
> > HATAYAMA, Daisuke
> >
> >
> 
> 
> -- 
> Best regards,
> Maxim Uvarov

-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
