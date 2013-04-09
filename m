Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-da0-x22b.google.com ([2607:f8b0:400e:c00::22b])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPMsp-0005GS-2F
 for kexec@lists.infradead.org; Tue, 09 Apr 2013 00:58:00 +0000
Received: by mail-da0-f43.google.com with SMTP id u36so2862688dak.16
 for <kexec@lists.infradead.org>; Mon, 08 Apr 2013 17:57:56 -0700 (PDT)
Date: Tue, 9 Apr 2013 08:57:30 +0800
From: Wang YanQing <udknight@gmail.com>
Subject: Re: [PATCH v2]kexec:i386:kexec-bzImage: Fix pass garbage command
 line to new kernel
Message-ID: <20130409005730.GA2041@udknight>
References: <20130408094358.GB23828@udknight> <51629338.5080906@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51629338.5080906@cn.fujitsu.com>
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
Cc: tjd21@cl.cam.ac.uk, kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, hari@in.ibm.com, zhangyanfei.yes@gmail.com

On Mon, Apr 08, 2013 at 05:51:52PM +0800, Zhang Yanfei wrote:
> I don't think the patch is necessary, please see below.

I think bootloader prepare garbage in the command line
buffer which will be passed  into kernel command line buffer 
is not good, and I should use RFC instead of PATCH in 
the subject, I haven't test this patch before send it out, sorry.

After all, I have no time to dig this problem deeper right now,
I will prepare another patch to fix it if I have time to understand 
all the relative codes about this problem.

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
