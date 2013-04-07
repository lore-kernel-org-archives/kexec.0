Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UOm1m-0005wB-Bo
 for kexec@lists.infradead.org; Sun, 07 Apr 2013 09:36:48 +0000
Received: by mail-pd0-f170.google.com with SMTP id 10so2697519pdi.29
 for <kexec@lists.infradead.org>; Sun, 07 Apr 2013 02:36:42 -0700 (PDT)
Date: Sun, 7 Apr 2013 17:35:41 +0800
From: Wang YanQing <udknight@gmail.com>
Subject: Re: [PATCH] i386:kexec-bzImage: Use "\0" as command line instead of
 empty command line
Message-ID: <20130407093540.GA4046@udknight>
References: <20130403094356.GA7259@udknight> <515FB809.3020103@gmail.com>
 <20130407010103.GA2176@udknight> <51610A32.6080200@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51610A32.6080200@cn.fujitsu.com>
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
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: jbarnes@sgi.com, tjd21@cl.cam.ac.uk, khalid.aziz@hp.com, kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, hari@in.ibm.com, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On Sun, Apr 07, 2013 at 01:54:58PM +0800, Zhang Yanfei wrote:
> With no commandline, can the new kernel boot?
> I tried in my box and the new kernel just panicked for it cannot
> find a root= argument in its commandline.
I am sure the kernel boot, 
rootfs_initcall(populate_rootfs) in initramfs.c
well populate the root fs, and there is a /init
in initramfs, this /init will mount the really 
root device, and the system is running.
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
