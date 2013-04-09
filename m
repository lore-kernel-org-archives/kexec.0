Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-da0-x22f.google.com ([2607:f8b0:400e:c00::22f])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPN3a-0005NN-T2
 for kexec@lists.infradead.org; Tue, 09 Apr 2013 01:09:07 +0000
Received: by mail-da0-f47.google.com with SMTP id s35so2859121dak.20
 for <kexec@lists.infradead.org>; Mon, 08 Apr 2013 18:09:04 -0700 (PDT)
Date: Tue, 9 Apr 2013 09:08:47 +0800
From: Wang YanQing <udknight@gmail.com>
Subject: Re: [PATCH v2]kexec:i386:kexec-bzImage: Fix pass garbage command
 line to new kernel
Message-ID: <20130409010847.GA3281@udknight>
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

> This is obviously wrong. 
Yes, it is obviously wrong
> Purgatory may append a kexec_jump_back_entry= argument into the commandline. It is
> an argument belongs to the commandline. So why there is a buf filled with 0 
> (alloc_command_line_len) before it in the commandline buf.
Kernel will copy all the COMMAND_LINE_SIZE len buffer pointer by 
cmd_line_ptr, but kexec-bzImage just prepare a very shorter buffer
in the below line check failed code path:

if (info->kexec_flags & (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT))

in the check sucess code path, it seems good by below line:
modified_cmdline = xmalloc(COMMAND_LINE_SIZE);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
