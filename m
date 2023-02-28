Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7F0C64ED6
	for <kexec@archiver.kernel.org>; Tue, 28 Feb 2023 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xz/bh9O9u55xxO1HVFZdiNoAEGLkKlCzmapOhWkgfb0=; b=KoG4oJ/1azzsDu
	tyd8kdu+0/YAG/jJCM6ijY5fYXoYi4B7caMuV1SqnxOfgWdAhmmUlJbOvqWRk/VPqUOsh7lrk3Pwn
	Rc1jE6qbtfrQ2svbOaZtNPdRZNIqqrOhir/QjGcDDZ3I1JQ0CvUAcjUN0zjHbrRjHGijL/zW3+nTq
	8ZVnxfdFS0D5TLjY7CEcx1KslToDFQzNXURCCkExX9xgcZLy3msYHU5Veqo4QNCxtXR9aFGGQiY4h
	YaCDnjtTAot7pa5zJNDD4LAXE8OBegDEmSuHAaENvO5L+DSdk4cdOeYaXPFKyYDjM+3WvuxnXdolT
	SHofe65grU0r9RhhzJQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWzLq-00DCbH-HP; Tue, 28 Feb 2023 12:45:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWzLj-00DCZY-9F
	for kexec@lists.infradead.org; Tue, 28 Feb 2023 12:44:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677588289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpQlkDCwLxZLi1wuwDnahs9h63rRCfzQes70p16hkkM=;
	b=LusZ4scxfkV5wZqzGlRqzwqQzjzPhPXHqJ/bmpKltS3AjSREKOM6+Ml/4+tb4Zfq5KM8WE
	Fsn01lPrq7KgCCc5rIyOdiF4zDnBxVFnNVMgpHQhprZbXChjN+MD9TR4KlY3rny/fJPZg3
	aGaijebztvwRD2HcXJr4VrrG+MhitS0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-ULDIvKDeOOOMe2XDOS9xPA-1; Tue, 28 Feb 2023 07:44:46 -0500
X-MC-Unique: ULDIvKDeOOOMe2XDOS9xPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35E1E802D38;
	Tue, 28 Feb 2023 12:44:45 +0000 (UTC)
Received: from localhost (ovpn-13-194.pek2.redhat.com [10.72.13.194])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B5D65140EBF6;
	Tue, 28 Feb 2023 12:44:43 +0000 (UTC)
Date: Tue, 28 Feb 2023 20:44:40 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Eric DeVolder <eric.devolder@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
	dyoung@redhat.com, vgoyal@redhat.com, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Message-ID: <Y/33OOdv22CEaTNA@MiWiFi-R3L-srv>
References: <20230131224236.122805-6-eric.devolder@oracle.com>
 <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com>
 <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
 <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_044455_457142_6A451BB7 
X-CRM114-Status: GOOD (  75.01  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 02/13/23 at 10:10am, Sourabh Jain wrote:
> =

> On 11/02/23 06:05, Eric DeVolder wrote:
> > =

> > =

> > On 2/10/23 00:29, Sourabh Jain wrote:
> > > =

> > > On 10/02/23 01:09, Eric DeVolder wrote:
> > > > =

> > > > =

> > > > On 2/9/23 12:43, Sourabh Jain wrote:
> > > > > Hello Eric,
> > > > > =

> > > > > On 09/02/23 23:01, Eric DeVolder wrote:
> > > > > > =

> > > > > > =

> > > > > > On 2/8/23 07:44, Thomas Gleixner wrote:
> > > > > > > Eric!
> > > > > > > =

> > > > > > > On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
> > > > > > > > On 2/1/23 05:33, Thomas Gleixner wrote:
> > > > > > > > =

> > > > > > > > So my latest solution is introduce two new CPUHP
> > > > > > > > states, CPUHP_AP_ELFCOREHDR_ONLINE
> > > > > > > > for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for
> > > > > > > > offlining. I'm open to better names.
> > > > > > > > =

> > > > > > > > The CPUHP_AP_ELFCOREHDR_ONLINE needs to be
> > > > > > > > placed after CPUHP_BRINGUP_CPU. My
> > > > > > > > attempts at locating this state failed when
> > > > > > > > inside the STARTING section, so I located
> > > > > > > > this just inside the ONLINE sectoin. The crash
> > > > > > > > hotplug handler is registered on
> > > > > > > > this state as the callback for the .startup method.
> > > > > > > > =

> > > > > > > > The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be
> > > > > > > > placed before CPUHP_TEARDOWN_CPU, and I
> > > > > > > > placed it at the end of the PREPARE section.
> > > > > > > > This crash hotplug handler is also
> > > > > > > > registered on this state as the callback for the .teardown =
method.
> > > > > > > =

> > > > > > > TBH, that's still overengineered. Something like this:
> > > > > > > =

> > > > > > > bool cpu_is_alive(unsigned int cpu)
> > > > > > > {
> > > > > > > =A0=A0=A0=A0struct cpuhp_cpu_state *st =3D per_cpu_ptr(&cpuhp=
_state, cpu);
> > > > > > > =

> > > > > > > =A0=A0=A0=A0return data_race(st->state) <=3D CPUHP_AP_IDLE_DE=
AD;
> > > > > > > }
> > > > > > > =

> > > > > > > and use this to query the actual state at crash
> > > > > > > time. That spares all
> > > > > > > those callback heuristics.
> > > > > > > =

> > > > > > > > I'm making my way though percpu crash_notes,
> > > > > > > > elfcorehdr, vmcoreinfo,
> > > > > > > > makedumpfile and (the consumer of it all) the
> > > > > > > > userspace crash utility,
> > > > > > > > in order to understand the impact of moving from
> > > > > > > > for_each_present_cpu()
> > > > > > > > to for_each_online_cpu().
> > > > > > > =

> > > > > > > Is the packing actually worth the trouble? What's the actual =
win?
> > > > > > > =

> > > > > > > Thanks,
> > > > > > > =

> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0 tglx
> > > > > > > =

> > > > > > > =

> > > > > > =

> > > > > > Thomas,
> > > > > > I've investigated the passing of crash notes through the
> > > > > > vmcore. What I've learned is that:
> > > > > > =

> > > > > > - linux/fs/proc/vmcore.c (which makedumpfile references
> > > > > > to do its job) does
> > > > > > =A0 not care what the contents of cpu PT_NOTES are, but it
> > > > > > does coalesce them together.
> > > > > > =

> > > > > > - makedumpfile will count the number of cpu PT_NOTES in
> > > > > > order to determine its
> > > > > > =A0 nr_cpus variable, which is reported in a header, but
> > > > > > otherwise unused (except
> > > > > > =A0 for sadump method).
> > > > > > =

> > > > > > - the crash utility, for the purposes of determining the
> > > > > > cpus, does not appear to
> > > > > > =A0 reference the elfcorehdr PT_NOTEs. Instead it locates the v=
arious
> > > > > > =A0 cpu_[possible|present|online]_mask and computes
> > > > > > nr_cpus from that, and also of
> > > > > > =A0 course which are online. In addition, when crash does
> > > > > > reference the cpu PT_NOTE,
> > > > > > =A0 to get its prstatus, it does so by using a percpu
> > > > > > technique directly in the vmcore
> > > > > > =A0 image memory, not via the ELF structure. Said
> > > > > > differently, it appears to me that
> > > > > > =A0 crash utility doesn't rely on the ELF PT_NOTEs for
> > > > > > cpus; rather it obtains them
> > > > > > =A0 via kernel cpumasks and the memory within the vmcore.
> > > > > > =

> > > > > > With this understanding, I did some testing. Perhaps the
> > > > > > most telling test was that I
> > > > > > changed the number of cpu PT_NOTEs emitted in the
> > > > > > crash_prepare_elf64_headers() to just 1,
> > > > > > hot plugged some cpus, then also took a few offline
> > > > > > sparsely via chcpu, then generated a
> > > > > > vmcore. The crash utility had no problem loading the
> > > > > > vmcore, it reported the proper number
> > > > > > of cpus and the number offline (despite only one cpu
> > > > > > PT_NOTE), and changing to a different
> > > > > > cpu via 'set -c 30' and the backtrace was completely valid.
> > > > > > =

> > > > > > My take away is that crash utility does not rely upon
> > > > > > ELF cpu PT_NOTEs, it obtains the
> > > > > > cpu information directly from kernel data structures.
> > > > > > Perhaps at one time crash relied
> > > > > > upon the ELF information, but no more. (Perhaps there
> > > > > > are other crash dump analyzers
> > > > > > that might rely on the ELF info?)
> > > > > > =

> > > > > > So, all this to say that I see no need to change
> > > > > > crash_prepare_elf64_headers(). There
> > > > > > is no compelling reason to move away from
> > > > > > for_each_present_cpu(), or modify the list for
> > > > > > online/offline.
> > > > > > =

> > > > > > Which then leaves the topic of the cpuhp state on which
> > > > > > to register. Perhaps reverting
> > > > > > back to the use of CPUHP_BP_PREPARE_DYN is the right
> > > > > > answer. There does not appear to
> > > > > > be a compelling need to accurately track whether the cpu
> > > > > > went online/offline for the
> > > > > > purposes of creating the elfcorehdr, as ultimately the
> > > > > > crash utility pulls that from
> > > > > > kernel data structures, not the elfcorehdr.
> > > > > > =

> > > > > > I think this is what Sourabh has known and has been
> > > > > > advocating for an optimization
> > > > > > path that allows not regenerating the elfcorehdr on cpu
> > > > > > changes (because all the percpu
> > > > > > structs are all laid out). I do think it best to leave
> > > > > > that as an arch choice.
> > > > > =

> > > > > Since things are clear on how the PT_NOTES are consumed in
> > > > > kdump kernel [fs/proc/vmcore.c],
> > > > > makedumpfile, and crash tool I need your opinion on this:
> > > > > =

> > > > > Do we really need to regenerate elfcorehdr for CPU hotplug events?
> > > > > If yes, can you please list the elfcorehdr components that
> > > > > changes due to CPU hotplug.
> > > > Due to the use of for_each_present_cpu(), it is possible for the
> > > > number of cpu PT_NOTEs
> > > > to fluctuate as cpus are un/plugged. Onlining/offlining of cpus
> > > > does not impact the
> > > > number of cpu PT_NOTEs (as the cpus are still present).
> > > > =

> > > > > =

> > > > > =A0From what I understood, crash notes are prepared for
> > > > > possible CPUs as system boots and
> > > > > could be used to create a PT_NOTE section for each possible
> > > > > CPU while generating the elfcorehdr
> > > > > during the kdump kernel load.
> > > > > =

> > > > > Now once the elfcorehdr is loaded with PT_NOTEs for every
> > > > > possible CPU there is no need to
> > > > > regenerate it for CPU hotplug events. Or do we?
> > > > =

> > > > For onlining/offlining of cpus, there is no need to regenerate
> > > > the elfcorehdr. However,
> > > > for actual hot un/plug of cpus, the answer is yes due to
> > > > for_each_present_cpu(). The
> > > > caveat here of course is that if crash utility is the only
> > > > coredump analyzer of concern,
> > > > then it doesn't care about these cpu PT_NOTEs and there would be
> > > > no need to re-generate them.
> > > > =

> > > > Also, I'm not sure if ARM cpu hotplug, which is just now coming
> > > > into mainstream, impacts
> > > > any of this.
> > > > =

> > > > Perhaps the one item that might help here is to distinguish
> > > > between actual hot un/plug of
> > > > cpus, versus onlining/offlining. At the moment, I can not
> > > > distinguish between a hot plug
> > > > event and an online event (and unplug/offline). If those were
> > > > distinguishable, then we
> > > > could only regenerate on un/plug events.
> > > > =

> > > > Or perhaps moving to for_each_possible_cpu() is the better choice?
> > > =

> > > Yes, because once elfcorehdr is built with possible CPUs we don't
> > > have to worry about
> > > hot[un]plug case.
> > > =

> > > Here is my view on how things should be handled if a core-dump
> > > analyzer is dependent on
> > > elfcorehdr PT_NOTEs to find online/offline CPUs.
> > > =

> > > A PT_NOTE in elfcorehdr holds the address of the corresponding crash
> > > notes (kernel has
> > > one crash note per CPU for every possible CPU). Though the crash
> > > notes are allocated
> > > during the boot time they are populated when the system is on the
> > > crash path.
> > > =

> > > This is how crash notes are populated on PowerPC and I am expecting
> > > it would be something
> > > similar on other architectures too.
> > > =

> > > The crashing CPU sends IPI to every other online CPU with a callback
> > > function that updates the
> > > crash notes of that specific CPU. Once the IPI completes the
> > > crashing CPU updates its own crash
> > > note and proceeds further.
> > > =

> > > The crash notes of CPUs remain uninitialized if the CPUs were
> > > offline or hot unplugged at the time
> > > system crash. The core-dump analyzer should be able to identify
> > > [un]/initialized crash notes
> > > and display the information accordingly.
> > > =

> > > Thoughts?
> > > =

> > > - Sourabh
> > =

> > In general, I agree with your points. You've presented a strong case to
> > go with for_each_possible_cpu() in crash_prepare_elf64_headers() and
> > those crash notes would always be present, and we can ignore changes to
> > cpus wrt/ elfcorehdr updates.
> > =

> > But what do we do about kexec_load() syscall? The way the userspace
> > utility works is it determines cpus by:
> > =A0nr_cpus =3D sysconf(_SC_NPROCESSORS_CONF);
> > which is not the equivalent of possible_cpus. So the complete list of
> > cpu PT_NOTEs is not generated up front. We would need a solution for
> > that?
> Hello Eric,
> =

> The sysconf document says _SC_NPROCESSORS_CONF is processors configured,
> isn't that equivalent to possible CPUs?
> =

> What exactly sysconf(_SC_NPROCESSORS_CONF) returns on x86? IIUC, on power=
PC
> it is possible CPUs.

From sysconf man page, with my understanding, _SC_NPROCESSORS_CONF is
returning the possible cpus, while _SC_NPROCESSORS_ONLN returns present
cpus. If these are true, we can use them.

But I am wondering why the existing present cpu way is going to be
discarded. Sorry, I tried to go through this thread, it's too long, can
anyone summarize the reason with shorter and clear sentences. Sorry
again for that.

> =

> In case sysconf(_SC_NPROCESSORS_CONF) is not consistent then we can go wi=
th:
> /sys/devices/system/cpu/possible for kexec_load case.
> =

> Thoughts?
> =

> - Sourabh Jain
> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
