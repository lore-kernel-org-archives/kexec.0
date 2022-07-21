Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0E5C43334
	for <kexec@archiver.kernel.org>; Thu, 21 Jul 2022 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C6Q3HEAxXQtVR0xpD6ZQF7MxdLaHtlQvrx+icjdlgFc=; b=A+NDwVISVN56VU
	bnYT+EGyjoeAB1QvcBfbSWkhBeZBsq7sZwj5xGi9rl+EUS1EjOykv3ammw1UXGkVn61RiVPsEjCbt
	rv3wo2iMZ2vDyWk5bAVs5JfxOipCiEXbKKShkr/II5ofL35zkfip2F30USG7+cuylsuxA7bdMSPTW
	qkQHhxPDODlmUkaihi5I1qp1h8Jhr2qcxunS6LTQ7hrD664RTiR3y9i+gMOpizXk67Dg6leW22MTp
	5dJBESXScmCwb3u+vV5TeLe0V6AkOxZbRlAMyJrRr0ronCphzu1ffCPtTrIXKg+2pP4fSVXlfe4YR
	ScSesFBUVM2+iRCDtIcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEJlW-00DfWe-GE; Thu, 21 Jul 2022 00:10:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEJjf-00DeOs-Us
	for kexec@lists.infradead.org; Thu, 21 Jul 2022 00:08:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658362087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbv739AZyL6A/AebD7p566yrz0K8D+GAOYHa2HePZks=;
	b=iTMrGMr2ZxtLRxVWJIplnK8nl6JCMX3G495GCCsSJqGcZo6j5ZCTO30q0KgmGOu5WdF1It
	7jP6WUgUWMGUPSj1zxQBeNiVtb0JEyuA3yXNln20WUa3PT7pjQ3Mrqg8XaA5Wh3WOwpx8J
	irRSgzy4BaxXjwld1JUt1fOCeLJYQ/A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-Y4xVkeU7OOyM1LvB2ElfTA-1; Wed, 20 Jul 2022 20:08:04 -0400
X-MC-Unique: Y4xVkeU7OOyM1LvB2ElfTA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A116880029D;
	Thu, 21 Jul 2022 00:08:03 +0000 (UTC)
Received: from localhost (ovpn-12-68.pek2.redhat.com [10.72.12.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 49B13492C3B;
	Thu, 21 Jul 2022 00:08:01 +0000 (UTC)
Date: Thu, 21 Jul 2022 08:07:57 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v9 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Message-ID: <YtiY3SI0UWAUBr9F@MiWiFi-R3L-srv>
References: <20220613224240.79400-1-eric.devolder@oracle.com>
 <51e85040-5622-dae2-dc28-f167660184f0@oracle.com>
 <YsTiUXjVL1ativXJ@MiWiFi-R3L-srv>
 <176bd603-05e9-2235-4052-dcca446098d7@oracle.com>
 <4ec347fb-0f1b-868d-d8a2-bc88a9f2ad54@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ec347fb-0f1b-868d-d8a2-bc88a9f2ad54@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_170812_241210_DF5B09F1 
X-CRM114-Status: GOOD (  60.09  )
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

On 07/20/22 at 02:08pm, Eric DeVolder wrote:
> Baoquan,
> I believe I've addressed all feedback, just checking to see if you agree.
> I have the next patch set ready in the event you think it a good idea to =
post it.
> Thanks!

Thanks for the effort. Please post them for reviewing. The newly made
change in this rounds looks good to me, esp the sysfs adding is very
great.

> =

> =

> On 7/7/22 08:05, Eric DeVolder wrote:
> > =

> > =

> > On 7/5/22 20:16, Baoquan He wrote:
> > > On 07/05/22 at 10:17am, Eric DeVolder wrote:
> > > > Nudge...
> > > > Thanks!
> > > =

> > > Seems DavidH has concern and rasied it after you posted v9. Is that
> > > solved?
> > =

> > In looking at David's comments on v8:
> > - [PATCH v8 2/7] crash: prototype change for crash_prepare_elf64_headers
> >  =A0 I adjusted per feedback and responded as such. He provided an Acke=
d-by.
> > =

> > - [PATCH v8 3/7] crash: add generic infrastructure for crash hotplug su=
pport
> >  =A0 He says do not use WARN* on expected error paths. I instead used W=
ARN_ONCE(),
> >  =A0 but I didn't consider this an error path. Nonetheless, I'll remove=
 the
> >  =A0 message altogether in v11.
> > =

> > - [PATCH v8 0/7] crash: Kernel handling of CPU and memory hot un/plug
> >  =A0 David muses about a better name, but that was in response to Soura=
bh's
> >  =A0 and I exchange on the sysfs attributes to use to report the presen=
ce
> >  =A0 of this feature. In the end, I used something altogether different=
, as
> >  =A0 presented in v10 (and the corresponding udev solution/change that =
goes
> >  =A0 hand in hand with it).
> > =

> > Let me know if I've missed anything else? Sourabh points out a build pr=
oblem
> > for architectures without this feature support, so a v11 is warranted. =
But I'll
> > wait to post that until I hear that I've addressed the previous questio=
ns.
> > =

> > Thanks,
> > eric
> > =

> > =

> > > =

> > > > =

> > > > On 6/13/22 17:42, Eric DeVolder wrote:
> > > > > When the kdump service is loaded, if a CPU or memory is hot
> > > > > un/plugged, the crash elfcorehdr (for x86), which describes the C=
PUs
> > > > > and memory in the system, must also be updated, else the resulting
> > > > > vmcore is inaccurate (eg. missing either CPU context or memory
> > > > > regions).
> > > > > =

> > > > > The current solution utilizes udev to initiate an unload-then-rel=
oad
> > > > > of the kdump image (e. kernel, initrd, boot_params, puratory and
> > > > > elfcorehdr) by the userspace kexec utility. In previous posts I h=
ave
> > > > > outlined the significant performance problems related to offloadi=
ng
> > > > > this activity to userspace.
> > > > > =

> > > > > This patchset introduces a generic crash hot un/plug handler that
> > > > > registers with the CPU and memory notifiers. Upon CPU or memory
> > > > > changes, this generic handler is invoked and performs important
> > > > > housekeeping, for example obtaining the appropriate lock, and then
> > > > > invokes an architecture specific handler to do the appropriate
> > > > > updates.
> > > > > =

> > > > > In the case of x86_64, the arch specific handler generates a new
> > > > > elfcorehdr, and overwrites the old one in memory. No involvement
> > > > > with userspace needed.
> > > > > =

> > > > > To realize the benefits/test this patchset, one must make a couple
> > > > > of minor changes to userspace:
> > > > > =

> > > > > =A0=A0 - Prevent udev from updating kdump crash kernel on hot un/=
plug changes.
> > > > > =A0=A0=A0=A0 Add the following as the first lines to the udev rul=
e file
> > > > > =A0=A0=A0=A0 /usr/lib/udev/rules.d/98-kexec.rules:
> > > > > =

> > > > > =A0=A0=A0=A0 # The kernel handles updates to crash elfcorehdr for=
 cpu and memory changes
> > > > > =A0=A0=A0=A0 SUBSYSTEM=3D=3D"cpu", ATTRS{crash_hotplug}=3D=3D"1",=
 GOTO=3D"kdump_reload_end"
> > > > > =A0=A0=A0=A0 SUBSYSTEM=3D=3D"memory", ATTRS{crash_hotplug}=3D=3D"=
1", GOTO=3D"kdump_reload_end"
> > > > > =

> > > > > =A0=A0=A0=A0 These lines will cause cpu and memory hot un/plug ev=
ents to be
> > > > > =A0=A0=A0=A0 skipped within this rule file, if the kernel has the=
se changes
> > > > > =A0=A0=A0=A0 enabled.
> > > > > =

> > > > > =A0=A0 - Change to the kexec_file_load for loading the kdump kern=
el:
> > > > > =A0=A0=A0=A0 Eg. on RHEL: in /usr/bin/kdumpctl, change to:
> > > > > =A0=A0=A0=A0=A0 standard_kexec_args=3D"-p -d -s"
> > > > > =A0=A0=A0=A0 which adds the -s to select kexec_file_load syscall.
> > > > > =

> > > > > This patchset supports kexec_load with a modified kexec userspace
> > > > > utility, and a working changeset to the kexec userspace utility
> > > > > is provided here (and to use, the above change to standard_kexec_=
args
> > > > > would be, for example, to append --hotplug instead of -s).
> > > > > =

> > > > > =A0=A0=A0 diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/ar=
ch/i386/crashdump-x86.c
> > > > > =A0=A0=A0 index 9826f6d..4ed395a 100644
> > > > > =A0=A0=A0 --- a/kexec/arch/i386/crashdump-x86.c
> > > > > =A0=A0=A0 +++ b/kexec/arch/i386/crashdump-x86.c
> > > > > =A0=A0=A0 @@ -48,6 +48,7 @@
> > > > > =A0=A0=A0=A0 #include <x86/x86-linux.h>
> > > > > =A0=A0=A0=A0 extern struct arch_options_t arch_options;
> > > > > =A0=A0=A0 +extern int do_hotplug;
> > > > > =A0=A0=A0=A0 static int get_kernel_page_offset(struct kexec_info =
*UNUSED(info),
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 struct crash_elf_info *elf_info)
> > > > > =A0=A0=A0 @@ -975,6 +976,14 @@ int load_crashdump_segments(struct=
 kexec_info *info, char* mod_cmdline,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 } else {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memsz =3D bufsz;
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > =A0=A0=A0 +
> > > > > =A0=A0=A0 +=A0=A0=A0 /* If hotplug support enabled, use larger si=
ze to accomodate changes */
> > > > > =A0=A0=A0 +=A0=A0=A0 if (do_hotplug) {
> > > > > =A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 long int nr_cpus =3D get_nr_cpus=
();
> > > > > =A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 memsz =3D (nr_cpus + CRASH_MAX_M=
EMORY_RANGES) * sizeof(Elf64_Phdr);
> > > > > =A0=A0=A0 +=A0=A0=A0 }
> > > > > =A0=A0=A0 +
> > > > > =A0=A0=A0 +=A0=A0=A0 info->elfcorehdr =3D
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 elfcorehdr =3D add_buffer(info, tmp, buf=
sz, memsz, align, min_base,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_addr, -1);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 dbgprintf("Created elf header segment at=
 0x%lx\n", elfcorehdr);
> > > > > =A0=A0=A0 diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-el=
f.c
> > > > > =A0=A0=A0 index b8bb686..5e29f7a 100644
> > > > > =A0=A0=A0 --- a/kexec/crashdump-elf.c
> > > > > =A0=A0=A0 +++ b/kexec/crashdump-elf.c
> > > > > =A0=A0=A0 @@ -43,11 +43,7 @@ int FUNC(struct kexec_info *info,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 int (*get_note_info)(int cpu, uint64_t *=
addr, uint64_t *len);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 long int count_cpu;
> > > > > =A0=A0=A0 -=A0=A0=A0 if (xen_present())
> > > > > =A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 nr_cpus =3D xen_get_nr_phys_cpus=
();
> > > > > =A0=A0=A0 -=A0=A0=A0 else
> > > > > =A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0 nr_cpus =3D sysconf(_SC_NPROCESS=
ORS_CONF);
> > > > > =A0=A0=A0 -
> > > > > =A0=A0=A0 +=A0=A0=A0 nr_cpus =3D get_nr_cpus();
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 if (nr_cpus < 0) {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -1;
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > =A0=A0=A0 diff --git a/kexec/crashdump.h b/kexec/crashdump.h
> > > > > =A0=A0=A0 index 18bd691..28d3278 100644
> > > > > =A0=A0=A0 --- a/kexec/crashdump.h
> > > > > =A0=A0=A0 +++ b/kexec/crashdump.h
> > > > > =A0=A0=A0 @@ -57,7 +57,6 @@ unsigned long phys_to_virt(struct cra=
sh_elf_info *elf_info,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigne=
d long long paddr);
> > > > > =A0=A0=A0=A0 unsigned long xen_architecture(struct crash_elf_info=
 *elf_info);
> > > > > =A0=A0=A0 -int xen_get_nr_phys_cpus(void);
> > > > > =A0=A0=A0=A0 int xen_get_note(int cpu, uint64_t *addr, uint64_t *=
len);
> > > > > =A0=A0=A0=A0 int xen_get_crashkernel_region(uint64_t *start, uint=
64_t *end);
> > > > > =A0=A0=A0 diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
> > > > > =A0=A0=A0 index 70fb576..f54a2dd 100644
> > > > > =A0=A0=A0 --- a/kexec/kexec-xen.h
> > > > > =A0=A0=A0 +++ b/kexec/kexec-xen.h
> > > > > =A0=A0=A0 @@ -83,5 +83,6 @@ extern int __xc_interface_close(xc_in=
terface *xch);
> > > > > =A0=A0=A0=A0 #endif
> > > > > =A0=A0=A0=A0 int xen_get_kexec_range(int range, uint64_t *start, =
uint64_t *end);
> > > > > =A0=A0=A0 +int xen_get_nr_phys_cpus(void);
> > > > > =A0=A0=A0=A0 #endif /* KEXEC_XEN_H */
> > > > > =A0=A0=A0 diff --git a/kexec/kexec.c b/kexec/kexec.c
> > > > > =A0=A0=A0 index 829a6ea..3668b73 100644
> > > > > =A0=A0=A0 --- a/kexec/kexec.c
> > > > > =A0=A0=A0 +++ b/kexec/kexec.c
> > > > > =A0=A0=A0 @@ -58,6 +58,7 @@
> > > > > =A0=A0=A0=A0 unsigned long long mem_min =3D 0;
> > > > > =A0=A0=A0=A0 unsigned long long mem_max =3D ULONG_MAX;
> > > > > =A0=A0=A0 +int do_hotplug =3D 0;
> > > > > =A0=A0=A0=A0 static unsigned long kexec_flags =3D 0;
> > > > > =A0=A0=A0=A0 /* Flags for kexec file (fd) based syscall */
> > > > > =A0=A0=A0=A0 static unsigned long kexec_file_flags =3D 0;
> > > > > =A0=A0=A0 @@ -489,6 +490,17 @@ static int add_backup_segments(str=
uct kexec_info *info,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > > =A0=A0=A0=A0 }
> > > > > =A0=A0=A0 +long int get_nr_cpus(void)
> > > > > =A0=A0=A0 +{
> > > > > =A0=A0=A0 +=A0=A0=A0 long int nr_cpus;
> > > > > =A0=A0=A0 +
> > > > > =A0=A0=A0 +=A0=A0=A0 if (xen_present())
> > > > > =A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 nr_cpus =3D xen_get_nr_phys_cpus=
();
> > > > > =A0=A0=A0 +=A0=A0=A0 else
> > > > > =A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 nr_cpus =3D sysconf(_SC_NPROCESS=
ORS_CONF);
> > > > > =A0=A0=A0 +=A0=A0=A0 return nr_cpus;
> > > > > =A0=A0=A0 +}
> > > > > =A0=A0=A0 +
> > > > > =A0=A0=A0=A0 static char *slurp_fd(int fd, const char *filename, =
off_t size, off_t *nread)
> > > > > =A0=A0=A0=A0 {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 char *buf;
> > > > > =A0=A0=A0 @@ -672,6 +684,14 @@ static void update_purgatory(struc=
t kexec_info *info)
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (info->segment[i].mem =3D=
=3D (void *)info->rhdr.rel_addr) {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > =A0=A0=A0 +
> > > > > =A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 /* Don't include elfcorehdr in t=
he checksum, if hotplug
> > > > > =A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0 * support enabled.
> > > > > =A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0 */
> > > > > =A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 if (do_hotplug && (info->segment=
[i].mem =3D=3D (void *)info->elfcorehdr)) {
> > > > > =A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> > > > > =A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > =A0=A0=A0 +
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sha256_update(&ctx, info->se=
gment[i].buf,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 info->segment[i].bufsz);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nullsz =3D info->segment[i].=
memsz - info->segment[i].bufsz;
> > > > > =A0=A0=A0 @@ -1565,6 +1585,9 @@ int main(int argc, char *argv[])
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case OPT_PRINT_CKR_SIZE:
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 print_crashkerne=
l_region_size();
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > > =A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0 case OPT_HOTPLUG:
> > > > > =A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 do_hotplug =3D 1;
> > > > > =A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default:
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > =A0=A0=A0 diff --git a/kexec/kexec.h b/kexec/kexec.h
> > > > > =A0=A0=A0 index 0f97a97..b0428cc 100644
> > > > > =A0=A0=A0 --- a/kexec/kexec.h
> > > > > =A0=A0=A0 +++ b/kexec/kexec.h
> > > > > =A0=A0=A0 @@ -169,6 +169,7 @@ struct kexec_info {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 int command_line_len;
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 int skip_checks;
> > > > > =A0=A0=A0 +=A0=A0=A0 unsigned long elfcorehdr;
> > > > > =A0=A0=A0=A0 };
> > > > > =A0=A0=A0=A0 struct arch_map_entry {
> > > > > =A0=A0=A0 @@ -231,7 +232,8 @@ extern int file_types;
> > > > > =A0=A0=A0=A0 #define OPT_PRINT_CKR_SIZE=A0=A0=A0 262
> > > > > =A0=A0=A0=A0 #define OPT_LOAD_LIVE_UPDATE=A0=A0=A0 263
> > > > > =A0=A0=A0=A0 #define OPT_EXEC_LIVE_UPDATE=A0=A0=A0 264
> > > > > =A0=A0=A0 -#define OPT_MAX=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 265
> > > > > =A0=A0=A0 +#define OPT_HOTPLUG=A0=A0=A0=A0=A0=A0=A0 265
> > > > > =A0=A0=A0 +#define OPT_MAX=A0=A0=A0=A0=A0=A0=A0 266
> > > > > =A0=A0=A0=A0 #define KEXEC_OPTIONS \
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 { "help",=A0=A0=A0=A0=A0=A0=A0 0, 0, OPT=
_HELP }, \
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 { "version",=A0=A0=A0=A0=A0=A0=A0 0, 0, =
OPT_VERSION }, \
> > > > > =A0=A0=A0 @@ -258,6 +260,7 @@ extern int file_types;
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 { "debug",=A0=A0=A0=A0=A0=A0=A0 0, 0, OP=
T_DEBUG }, \
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 { "status",=A0=A0=A0=A0=A0=A0=A0 0, 0, O=
PT_STATUS }, \
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 { "print-ckr-size",=A0=A0=A0=A0 0, 0, OP=
T_PRINT_CKR_SIZE }, \
> > > > > =A0=A0=A0 +=A0=A0=A0 { "hotplug",=A0=A0=A0=A0=A0=A0=A0 0, 0, OPT_=
HOTPLUG }, \
> > > > > =A0=A0=A0=A0 #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
> > > > > =A0=A0=A0 @@ -290,6 +293,8 @@ extern unsigned long add_buffer_phy=
s_virt(struct kexec_info *info,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 int buf_end, int phys);
> > > > > =A0=A0=A0=A0 extern void arch_reuse_initrd(void);
> > > > > =A0=A0=A0 +extern long int get_nr_cpus(void);
> > > > > =A0=A0=A0 +
> > > > > =A0=A0=A0=A0 extern int ifdown(void);
> > > > > =A0=A0=A0=A0 extern char purgatory[];
> > > > > =

> > > > > Regards,
> > > > > eric
> > > > > ---
> > > > > =

> > > > > v9: 13jun2022
> > > > > =A0=A0 - Rebased to 5.18.0
> > > > > =A0=A0 - Per Sourabh, moved crash_prepare_elf64_headers() into co=
mmon
> > > > > =A0=A0=A0=A0 crash_core.c to avoid compile issues with kexec_load=
 only path.
> > > > > =A0=A0 - Per David Hildebrand, replaced mutex_trylock() with mute=
x_lock().
> > > > > =A0=A0 - Changed the __weak arch_crash_handle_hotplug_event() to =
utilize
> > > > > =A0=A0=A0=A0 WARN_ONCE() instead of WARN(). Fix some formatting i=
ssues.
> > > > > =A0=A0 - Per Sourabh, introduced sysfs attribute crash_hotplug fo=
r memory
> > > > > =A0=A0=A0=A0 and CPUs; for use by userspace (udev) to determine i=
f the kernel
> > > > > =A0=A0=A0=A0 performs crash hot un/plug support.
> > > > > =A0=A0 - Per Sourabh, moved the code detecting the elfcorehdr seg=
ment from
> > > > > =A0=A0=A0=A0 arch/x86 into crash_core:handle_hotplug_event() so b=
oth kexec_load
> > > > > =A0=A0=A0=A0 and kexec_file_load can benefit.
> > > > > =A0=A0 - Updated userspace kexec-tools kexec utility to reflect c=
hange to
> > > > > =A0=A0=A0=A0 using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
> > > > > =

> > > > > v8: 5may2022
> > > > > =A0=A0 https://lkml.org/lkml/2022/5/5/1133
> > > > > =A0=A0 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in =
favor
> > > > > =A0=A0=A0=A0 of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a=
 new define
> > > > > =A0=A0=A0=A0 is not needed. Also use of IS_ENABLED() rather than =
#ifdef's.
> > > > > =A0=A0=A0=A0 Renamed crash_hotplug_handler() to handle_hotplug_ev=
ent().
> > > > > =A0=A0=A0=A0 And other corrections.
> > > > > =A0=A0 - Per Baoquan, minimized the parameters to the arch_crash_
> > > > > =A0=A0=A0=A0 handle_hotplug_event() to hp_action and cpu.
> > > > > =A0=A0 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Bao=
quan.
> > > > > =A0=A0 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_E=
LFCOREHDR_SZ
> > > > > =A0=A0=A0=A0 to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-t=
ools change
> > > > > =A0=A0=A0=A0 by David Hildebrand. Folded this patch into the x86
> > > > > =A0=A0=A0=A0 kexec_file_load support patch.
> > > > > =

> > > > > v7: 13apr2022
> > > > > =A0=A0 https://lkml.org/lkml/2022/4/13/850
> > > > > =A0=A0 - Resolved parameter usage to crash_hotplug_handler(), per=
 Baoquan.
> > > > > =

> > > > > v6: 1apr2022
> > > > > =A0=A0 https://lkml.org/lkml/2022/4/1/1203
> > > > > =A0=A0 - Reword commit messages and some comment cleanup per Baoq=
uan.
> > > > > =A0=A0 - Changed elf_index to elfcorehdr_index for clarity.
> > > > > =A0=A0 - Minor code changes per Baoquan.
> > > > > =

> > > > > v5: 3mar2022
> > > > > =A0=A0 https://lkml.org/lkml/2022/3/3/674
> > > > > =A0=A0 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
> > > > > =A0=A0=A0=A0 David Hildenbrand.
> > > > > =A0=A0 - Refactored slightly a few patches per Baoquan recommenda=
tion.
> > > > > =

> > > > > v4: 9feb2022
> > > > > =A0=A0 https://lkml.org/lkml/2022/2/9/1406
> > > > > =A0=A0 - Refactored patches per Baoquan suggestsions.
> > > > > =A0=A0 - A few corrections, per Baoquan.
> > > > > =

> > > > > v3: 10jan2022
> > > > > =A0=A0 https://lkml.org/lkml/2022/1/10/1212
> > > > > =A0=A0 - Rebasing per Baoquan He request.
> > > > > =A0=A0 - Changed memory notifier per David Hildenbrand.
> > > > > =A0=A0 - Providing example kexec userspace change in cover letter.
> > > > > =

> > > > > RFC v2: 7dec2021
> > > > > =A0=A0 https://lkml.org/lkml/2021/12/7/1088
> > > > > =A0=A0 - Acting upon Baoquan He suggestion of removing elfcorehdr=
 from
> > > > > =A0=A0=A0=A0 the purgatory list of segments, removed purgatory co=
de from
> > > > > =A0=A0=A0=A0 patchset, and it is signficiantly simpler now.
> > > > > =

> > > > > RFC v1: 18nov2021
> > > > > =A0=A0 https://lkml.org/lkml/2021/11/18/845
> > > > > =A0=A0 - working patchset demonstrating kernel handling of hotplug
> > > > > =A0=A0=A0=A0 updates to x86 elfcorehdr for kexec_file_load
> > > > > =

> > > > > RFC: 14dec2020
> > > > > =A0=A0 https://lkml.org/lkml/2020/12/14/532
> > > > > =A0=A0 - proposed concept of allowing kernel to handle hotplug up=
date
> > > > > =A0=A0=A0=A0 of elfcorehdr
> > > > > ---
> > > > > =

> > > > > =

> > > > > Eric DeVolder (7):
> > > > > =A0=A0=A0 crash: move crash_prepare_elf64_headers
> > > > > =A0=A0=A0 crash: prototype change for crash_prepare_elf64_headers
> > > > > =A0=A0=A0 crash: add generic infrastructure for crash hotplug sup=
port
> > > > > =A0=A0=A0 kexec: exclude elfcorehdr from the segment digest
> > > > > =A0=A0=A0 kexec: exclude hot remove cpu from elfcorehdr notes
> > > > > =A0=A0=A0 crash: memory and cpu hotplug sysfs attributes
> > > > > =A0=A0=A0 x86/crash: Add x86 crash hotplug support
> > > > > =

> > > > > =A0=A0 .../admin-guide/mm/memory-hotplug.rst=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0=A0 8 +
> > > > > =A0=A0 Documentation/core-api/cpu_hotplug.rst=A0=A0=A0=A0=A0=A0=
=A0 |=A0 18 ++
> > > > > =A0=A0 arch/arm64/kernel/machine_kexec_file.c=A0=A0=A0=A0=A0=A0=
=A0 |=A0=A0 6 +-
> > > > > =A0=A0 arch/powerpc/kexec/file_load_64.c=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |=A0=A0 2 +-
> > > > > =A0=A0 arch/x86/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 11 +
> > > > > =A0=A0 arch/x86/kernel/crash.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 119 ++++++++-
> > > > > =A0=A0 drivers/base/cpu.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 13 +
> > > > > =A0=A0 drivers/base/memory.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 13 +
> > > > > =A0=A0 include/linux/crash_core.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 12 +
> > > > > =A0=A0 include/linux/kexec.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 14 +-
> > > > > =A0=A0 kernel/crash_core.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 241 ++++++++++++++++++
> > > > > =A0=A0 kernel/kexec_file.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 105 +-------
> > > > > =A0=A0 12 files changed, 456 insertions(+), 106 deletions(-)
> > > > > =

> > > > =

> > > =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
