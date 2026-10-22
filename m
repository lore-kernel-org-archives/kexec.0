Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E525606A31E
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 01:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=suondFzR;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Zl6kbnlb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Y36cJrGfm0nAc8Wmqdrcv/voRViXSaKg8Lp3TDSNEQ=; b=suondFzR2K1pmbjfinXDKDWLVZ
	ifvRSeYBLJAUO8MNOwWAxzFW9rJqiBVC5ttUyvqvg65z/6ksnyTiW4RoeurGwJ6prcN+gydHhHshK
	s3jwjF1MSlWT+KC4rzbSMPck3aP9HQemN0OsJzg+ihwM3lnGKyI9rIPr/W2IAnN9udWZqijq4A12l
	1I8YrIlSGgUEntR2wl7RtM5mTthXo3ZvZ6SMYMyW6X9fPqLxelOD3XCi4fKsH8NER95VZ8Exclsn9
	x8c/Fz824svuVu2Ui/Xv/46g2QwVZGMPbLvryqVLLOsXEOXKczyun85L1v1NTLDT9gZeECVD+8a0K
	ZcSVxnWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJhLW-0000000D88i-2aly;
	Thu, 22 Oct 2026 01:11:54 +0000
Received: from out-27.mta1.migadu.com ([2001:41d0:203:375::1b] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJhLT-0000000D88I-3RzT
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 01:11:53 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=MZEjInp2ddcRxgm7ccCZwPxHcYRwDLMGllQTsvOicec=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792631508; v=1; x=1793236308;
 b=Zl6kbnlbrg74N/9P86yMpt7QPIZbsUt3z3XFOmlwc9tm5UDaxWa4xJoUAJ9T7RPO4sxTGFy1
 stb4J1nxH/rhSlQsPjPauA0oEUbi8Ps9xR9vx0m4mJLTDuFxLUcEStVQJIMo+A/b3dU6AkUZoR3
 66r5Pztit7rolv2Op73ap7VQ=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id defcd29a0076fd96;
	Thu, 22 Oct 2026 01:11:48 +0000
X-Mizu-Trace-ID: defcd29a0076fd96
X-Migadu-Flow: FLOW_OUT
Date: Thu, 22 Oct 2026 09:11:40 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Petr Mladek <pmladek@suse.com>, Zack Rusin <zack.rusin@broadcom.com>
Subject: Re: [PATCH v2 1/6] panic: Add a notifier chain for pre-kdump
 callbacks
Message-ID: <atlizIy3lb0sjVEJ@MiWiFi-R3L-srv>
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
X-CRM114-CacheID: sfid-20261021_181152_088775_9F4A3B1C 
X-CRM114-Status: GOOD (  56.44  )
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
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Pratyush Yadav <pratyush@kernel.org>, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
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
...snip...
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

When I revisited this thread, I suddenly realize I may made mistake on
comments. You folks seem to discussing the platform relatd handlers and
list, but not generic handlers and list. If so, I am not sure if my
suggestion is suitable because I didn't know these platforms well, esp
the various virt platforms and their correspondent handlers.

If the next steps also involve the generic handler part, my suggestions
may be relevant and could be of some reference value.

Thanks
Baoquan

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
> 
> Best Regards,
> Petr

