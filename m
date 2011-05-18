Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pz0-f49.google.com ([209.85.210.49])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QMakL-0006vR-6p
	for kexec@lists.infradead.org; Wed, 18 May 2011 07:00:41 +0000
Received: by pzk28 with SMTP id 28so683703pzk.36
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 00:00:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <iqvasm$ctv$1@dough.gmane.org>
References: <OFC164F955.6ED93986-ON86257893.00589FE8-86257893.006037E5@us.ibm.com>
	<iqvasm$ctv$1@dough.gmane.org>
Date: Wed, 18 May 2011 03:00:39 -0400
Message-ID: <BANLkTi=q+jJW+xyjdKCfJ9zzVmaV58oyzw@mail.gmail.com>
Subject: Re: kdump with /proc/oldproc
From: Maxim Uvarov <muvarov@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org

2011/5/17 WANG Cong <xiyou.wangcong@gmail.com>:
> On Tue, 17 May 2011 12:30:58 -0500, Nathan D Miller wrote:
>
>> Hello-
>>
>> Has anyone tried reconstituting a portion of the old kernel's /proc
>> while in the capture kernel?
>>
>> I had the idea while digging through the kexec/kdump code and it seemed
>> intriguing.
>>
>> It might be a means by which user-space dump applications running under
>> the capture kernel could interrogate the old system, and identify bad
>> processes that instigated the panic. =A0In particular, I'm thinking of O=
ut
>> Of Memory scenarios. =A0 We've modified our kernel to panic instead of
>> invoking the kernel's OOM killer, but we still have the problem of
>> identifying the "bad" process while running in the capture kernel.
>>
>> Perhaps everything could be accomplished using some sort of FUSE
>> file-system around /proc/oldmem and /proc/vmcore. =A0Not all the
>> proc/<pid>/ files would need to be implemented, of course. =A0In additio=
n,
>> each old process could have its own 'vmcore' file for getting a core
>> dump of the original process.
>>
>
> Well, actually you don't need to bother the old /proc
> to find which process is the killer. The old dmesg contains
> the PID/comm of the killer process, and we have a tool named
> vmcore-dmesg to read out the dmesg from the vmcore.
>
> With the utility 'crash', you can query any info of any process
> in the old kernel, so why do you need a per-process vmcore anyway?
>

If you use one of the latest kernel and gdb you can do it with gdb
without  crash or vmcore-dmesg.

> Thanks.
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>



-- =

Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
