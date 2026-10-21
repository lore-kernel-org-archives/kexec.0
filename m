Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D760C606A319
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lJblgMXZ;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mdkwIIQe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q+m/q38EBTs2um+nrrdp+oHaGDwfpAAfBNiqATdHRqE=; b=lJblgMXZutJXB5fjwT61BLU5NO
	e15I2LY0WGG2s6iciwvFMp3JebWe3DqalxMyJv2xl82Q7qxg+j5Zm8JnJPE7rqL5q0f6BfgqdfZMi
	Xd69HdOGwD6i8iz13SK1ozsCtaBDK19lXLlOWyG9hzjDfqDSQ2niwjARn9IE7Ggp4nNHZizh8XadW
	0iy43XYSiDin5SW+hxuJqqC/Xflx6lJdIVbcAx2BU2iX8o7W4EAMELn9DlQ3HNqF3Exb4XymNzVTp
	FCBqfP9fP6RHNCRcT5scv52w0ZfVBftrZuw/Uc0oNcIoj6ZpcMKCcEktvmP9c4Ucjkel0baWH+qHv
	PbZtF3xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJSpq-0000000BVpa-16Pq;
	Wed, 21 Oct 2026 09:42:14 +0000
Received: from out-87.mta0.migadu.com ([2001:41d0:1004:224b::57] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJSpm-0000000BVoh-3KLZ
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 09:42:12 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=7/htGxXtUHzJVlhZRgi4vB3k91+uiABHA1iTwy584Es=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792575726; v=1; x=1793180526;
 b=mdkwIIQeYGie42VYmFYr+v1lrDLwSEw+U5SIPN2s8mncrhHvq88rROIIyfXQNkofmM1Yq5G8
 Ri4soAdD+1r9uCuY6wQFoyD59/OlbCGsI01OOlnGBhSZOG83UVE2b9KCEuwX5bqOhwq9ApuAvJ6
 TjCHqjwfpglYhwazed9SIaHk=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id 24c5f096957bb0b7;
	Wed, 21 Oct 2026 09:42:05 +0000
X-Mizu-Trace-ID: 24c5f096957bb0b7
X-Migadu-Flow: FLOW_OUT
Date: Wed, 21 Oct 2026 17:41:59 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 1/6] panic: Add a notifier chain for pre-kdump
 callbacks
Message-ID: <atiI52kl--_Z_wVc@fedora>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
 <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com>
 <atdYIxwz8ksYNty6@pathway.suse.cz>
 <atd7GInNurGWLUha@pathway.suse.cz>
 <ateYxCu63pRY9EGq@pathway.suse.cz>
 <CABQX2QOKCpoUY_ObhFif7xN7OF-NzcxEM0JABAXo9n9KaacO7A@mail.gmail.com>
 <atgdwrSbsZD5iWsX@fedora>
 <CABQX2QO6fwvKZwG34uOYDU_ae4M4_n2SMsYmqoLgOPnWkao02w@mail.gmail.com>
 <atiDsmnUM7v2UJkY@pathway.suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atiDsmnUM7v2UJkY@pathway.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_024210_982217_53C7E43A 
X-CRM114-Status: GOOD (  69.76  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Zack Rusin <zack.rusin@broadcom.com>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Pratyush Yadav <pratyush@kernel.org>, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 at 11:19am, Petr Mladek wrote:
> On Wed 2026-10-21 01:10:25, Zack Rusin wrote:
> > On Tue, Oct 20, 2026 at 10:04 PM Baoquan He <baoquan.he@linux.dev> wrote:
> > >
> > > On 10/20/26 at 03:23pm, Zack Rusin wrote:
> > > > Hi, Petr.
> > > >
> > > > First of all I really appreciate you going over this. Thanks!
> > > >
> > > > On Tue, Oct 20, 2026 at 12:37 PM Petr Mladek <pmladek@suse.com> wrote:
> > > > > Approach B: Three lists: platform, smp_safe, and smp_unsafe()
> > > > > =============================================================
> > > > >
> > > > > It is similar to approach A. We would just add an extra:
> > > > >
> > > > >      + panic_notifiers_platform_list
> > > > >      + disable_panic_notifiers_platform_list
> > > > >
> > > > > This list would be used for smp-safe notifiers which are
> > > > > required be some platform. It would be the notifiers which
> > > > > are crucial. Which are currently the reason to set
> > > > > "_crash_kexec_post_notifiers".
> > > > >
> > > > > It might be called also when __crash_kexec() is called
> > > > > outside panic().
> > > > [...]
> > > > > This patchset, adding vmware_log_notifier, might implement just
> > > > > the panic_notifiers_platform_list. The rest might be
> > > > > added by another volunteer.
> > > > >
> > > > > How does this sounds, please?
> > > >
> > > > That sounds good to me. For v3 I'd do just the platform list:
> > > >
> > > > - One call in vpanic(), right after kgdb_panic() and before the first
> > > > __crash_kexec(), whatever crash_kexec_post_notifiers is set to. The
> > > > list runs before kdump and before the other CPUs are stopped.
> > > > - One call in __crash_kexec(), after it has taken the kexec lock,
> > > > found a crash image and saved the registers, for paths that enter
> > > > kdump without panic(), like oops_end() or Hyper-V's hv_crash_handle().
> > > > Once the early panic call has run the list, the guard makes this one a
> > > > no-op. That removes the dependence on crash_kexec_post_notifiers you
> > > > pointed out before.
> > > > - A once-only guard shared by both, so the list also runs only once
> > > > when a callback panics.
> 
> Just to be sure. I think that a simple static bool or int should be
> enough. The caller is responsible for the synchronization. I believe
> that it should be done by the "panic_cpu".
> 
> > > > - disable_panic_notifiers_platform_list as a boot and runtime switch,
> > > > checked in the same helper, replacing panic_pre_kdump_postpone.
> > > > - Kernel-doc with your definition: smp-safe callbacks a platform
> > > > needs, which would otherwise be a reason to set
> > > > crash_kexec_post_notifiers.
> > > >
> > > > Roughly:
> > > >         kgdb_panic(buf);
> > > >
> > > >         panic_notify_platform();
> > > >
> > > >         if (!_crash_kexec_post_notifiers)
> > > >                 __crash_kexec(NULL);
> > > >
> > > > and in __crash_kexec():
> > > >
> > > >         crash_setup_regs(&fixed_regs, regs);
> > > >         /* Direct entry outside panic() */
> > > >         panic_notify_platform();
> > > >         crash_save_vmcoreinfo();
> > > >
> > > > I'd keep the second call in __crash_kexec() rather than crash_kexec(),
> > > > because afaict crash_kexec() can return without a crash image, e.g.
> > > > from the BPF kfunc, or from oops_end() before it panics. Calling the
> > > > list there would use up the guard even when no kdump follows.
> > > >
> > > > crash_kexec_post_notifiers, the existing list and the kmsg dumpers
> > > > stay as they are, and moving other platforms over can come later.
> > > >
> > > > The VMware log copy would be the only user, and it's still best-effort
> > > > diagnostics: kdump and the reboot don't depend on it. It copies the
> > > > log tail into an 8 KiB buffer. On panic() that happens after the panic
> > > > message and any local backtrace; on direct entry from an oops, after
> > > > the exception output. With the list enabled throughout, the copy
> > > > precedes the later panic notifiers, sys_info() and the all-CPU
> > > > backtrace step. The guest-crash report stays a late kmsg dumper that's
> > > > skipped while a crash kernel is loaded, because the host can power off
> > > > the VM inside that call.
> > > >
> > > > If that matches what you had in mind, I'll do it that way in v3.
> > > >
> > > > Guilherme, Stephen, Baoquan, does that work for you too?
> > >
> > > Hi Zack,
> > >
> > > Sorry I didn't check this series before, just trying to catch up.
> > >
> > > I like the Approach B direction: one panic_notifiers_platform_list for
> > > platform callbacks that must run before kdump. While I have one concern
> > > about the long term.
> > >
> > > Today the list has only the VMware log sender. Later, more handlers may join
> > > (for example pvpanic, Hyper-V, Xen, gsmi, SNP). When the list grows, someone
> > > will want to run only their handler, or to skip some handlers. The easy
> > > answer is "add a new list for my handler". I think this will be a problem too
> > > in the future. Every new list adds a new global ordering rule and a new disable
> > > switch. Petr already said we should keep the number of lists small.
> 
> My hope is most of the potential users won't be registered at the same
> time or will be a NOP in the real life. Because each particular system
> will actively used only some technology.
> 
> But maybe I am naive and there will be selection and ordering problems.

If they are all platform related handling, that's fine. The platform system
vendor can wrap them up in one handler, and usually the handler is a
msut-be-done thing. If a platform system user wants to add an action for
their own, that could be different. I am not very sure either. Unless we
can collect information and be certain this won't happen.

> 
> > > Currently, atomic_notifier_call_chain() runs all registered callbacks. There
> > > is no per-handler enable/disable and no filter. NOTIFY_STOP_MASK can stop the
> > > chain, but we must not use it here, because one handler could hide all the
> > > later handlers. The list-level disable_panic_notifiers_platform_list can
> > > only disable the whole list.
> > >
> > > I have some rough though, just for reference:
> > >
> > > 1. Keep one panic_notifiers_platform_list.
> > >
> > > 2. Give each handler a small wrapper with a name and an enabled flag:
> > >
> > >    struct panic_pre_kdump_notifier {
> > >            struct notifier_block nb;
> > >            const char *name;
> > >            bool enabled;
> > >    };
> 
> This looks good to me.
> 
> > > 3. In the dispatch, skip a handler when enabled is false. Print the name
> > >    before calling it. This also helps when a handler hangs and we want to
> > >    know which one it was.
> > >
> > > 4. Add a boot parameter to disable handlers by name, for example:
> > >
> > >            panic_pre_kdump.disable=vmware_log,hyperv_crash
> 
> I like this. I think that we just would want to do s/_pre_dump/_notifiers_platform/.

Sure, the name is just for demonstrating.

> 
> > >    Parse it early. At panic time we only read the flag. We do not parse
> > >    strings in the panic path.
> > >
> > > 5. Keep the list-level disable_panic_notifiers_platform_list. It is still
> > >    useful to disable the whole list for debugging.
> > >
> > > 6. If the list is still too broad later, we can add a reason/class argument
> > >    (for example PANIC, OOPS_DIRECT). A handler can then decide if it cares.
> > >    This is better than adding a new list.
> > 
> > Thanks for looking at it. I agree we shouldn't add a separate list for
> > each handler, and named handlers with their own switch on the one list
> > sound like the right way to grow it.
> > 
> > For v3 I'd like to keep the series to the list itself. With VMware as
> > the only callback, the list-wide boot switch already lets us disable
> > platform logging. The sender also has its own sysctl,
> > kernel.vmware_record_panic_msg. We can add per-handler selection with
> > the next user, when there's an actual choice between handlers. I'm
> > happy to help with that when it comes up.
> 
> Sound good to me. I would like to start simple. We could add the selection
> later when it is needed in the real life.
> 
> > Two of your points do fit in v3 as documentation. I'll change the
> > panic_notify_platform() kernel-doc to also say that:
> > - callbacks must return NOTIFY_DONE, because NOTIFY_STOP would skip
> > the callbacks after them
> > - the notifier value is 0.
> 
> Great catch!
> 
> > The VMware callback ignores that value, which leaves room to add
> > reason information later.
> > 
> > Petr, does keeping v3 to that sound right to you?
> 
> Sounds good to me. But you might want to wait few more days for
> more potential feedback.

ACK.

