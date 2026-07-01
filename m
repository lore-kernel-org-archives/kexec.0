Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6A0C43458
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u9vIgqlb5PzQumgrF7Npwpto2QFwHQxQQBOLn0q9I5Q=; b=wSDMMA3AyPLor3azatTEEbeIeZ
	5hr2VySePEs7ND6h0gsvtYPTWSBcq4GRAXODrXEwhmtpDUePzn3JCv7+p9QWTNc+ISajHWvCrgpYq
	A64MEzej/x2gAZKw+cP8/wT8nOPNmRvAgf/QatK+kCa7VfsQQt5eZv02ocrnCLXcitfc+qfcZnxaW
	5pCziLLHS/pDqBvACcSH+uIfF24QQWvr8ayuqBFKMGlBBlpZp+smJWMPQI8C3P82Hf2b4PU7ufwKi
	pbSBFbh+Fxe13Y45dR8eE+5ldFYLF+E6LtNQvd3a+J7867rZ4pvcI6Vrj9HTz5tCKSibW4dJrV4MM
	z21W4BpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wetqs-00000001ofq-1pYC;
	Wed, 01 Jul 2026 12:15:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wetqr-00000001ofW-43Hj
	for kexec@lists.infradead.org;
	Wed, 01 Jul 2026 12:15:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6FF16423BE;
	Wed,  1 Jul 2026 12:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BC21F000E9;
	Wed,  1 Jul 2026 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782908137;
	bh=u9vIgqlb5PzQumgrF7Npwpto2QFwHQxQQBOLn0q9I5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=osDeNUtRA6PQBEPedTeWhJRfP/tCCXhUr/ZNMGCnyo+9SavtNZmLKrTe8+CU+dO7A
	 F9kMlvB8YKik/gZLC9IIa8adwsJYzBJC0q/lSL3cVKEr7qSkwPL3TWaSRyIi3NzP2V
	 fuzp+nC4O/o+xBUqfEICXBFStZpayvVK60JYi36RgD0xf3zjBfPdWxr5O3002pqbzF
	 GGd9CS4JQnCHv1oJ/YgD6zJTEswVMLsLojleLBtmsjwqOe9G0TxuPk+HfEXhTwBVc6
	 E4+de2OsNisZ1L5LtiS0REhRgR1PgRcOVr2+RX9UQiCCi2Xigd3Es3VXkZ4XHlc7be
	 XVVAjwgsMgXww==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Chenghao Duan <duanchenghao@kylinos.cn>,  Pratyush Yadav
 <pratyush@kernel.org>,  viro@zeniv.linux.org.uk,  brauner@kernel.org,
  jack@suse.cz,  linux-fsdevel@vger.kernel.org,  pasha.tatashin@soleen.com,
  linux-kernel@vger.kernel.org,  rppt@kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  jianghaoran@kylinos.cn
Subject: Re: [PATCH v1 1/2] eventfd: luo: luo support for preserving eventfd
In-Reply-To: <CALzav=c+RzWpJTrpsdwnHUT=EZCGv=FGtmDq9ipDE7jNuWNX0g@mail.gmail.com>
	(David Matlack's message of "Tue, 30 Jun 2026 15:55:11 -0700")
References: <20260625054946.73445-1-duanchenghao@kylinos.cn>
	<20260625054946.73445-2-duanchenghao@kylinos.cn>
	<2vxzfr2bkn0j.fsf@kernel.org> <20260629100621.GA215869@chenghao-pc>
	<CALzav=c+RzWpJTrpsdwnHUT=EZCGv=FGtmDq9ipDE7jNuWNX0g@mail.gmail.com>
Date: Wed, 01 Jul 2026 14:15:33 +0200
Message-ID: <2vxztsqihpne.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Jun 30 2026, David Matlack wrote:

> On Mon, Jun 29, 2026 at 3:06=E2=80=AFAM Chenghao Duan <duanchenghao@kylin=
os.cn> wrote:
>>
>> On Thu, Jun 25, 2026 at 11:06:04AM +0200, Pratyush Yadav wrote:
>> > On Thu, Jun 25 2026, Chenghao Duan wrote:
>> >
>> > > This patch adds support for preserving eventfd file descriptors acro=
ss
>> > > kexec live updates using the Live Update Orchestrator (LUO) framewor=
k.
>> > > Userspace applications using eventfd for event notification can now
>> > > maintain their state across kernel updates.
>> > >
>> > > Preserved State:
>> > > The following properties of the eventfd are preserved across kexec:
>> > > - Counter Value: The current 64-bit counter value, including any pen=
ding
>> > >   events that have been signaled but not yet consumed by readers.
>> > > - File Flags: The creation flags (EFD_SEMAPHORE, EFD_CLOEXEC, EFD_NO=
NBLOCK)
>> > >   are preserved.
>> > >
>> > > Non-Preserved State:
>> > > - File Descriptor Number: The eventfd will be assigned a new fd numb=
er
>> > >   in the target process after restore.
>> > > - Wait Queue State: Any processes blocked on read() operations will =
be
>> > >   woken up and need to re-establish their blocking state.
>> > > - All other internal state is reset to default.
>> > >
>> > > Changes:
>> > > - fs/eventfd.c: Add eventfd_luo_get_state() to safely read eventfd s=
tate
>> > >   (count and flags), and eventfd_create() helper function.
>> > > - fs/eventfd_luo.c: New file implementing LUO file operations:
>> > >   preserve, freeze, unpreserve, retrieve, and finish callbacks.
>> > > - include/linux/eventfd.h: Export new functions.
>> > > - include/linux/kho/abi/eventfd.h: Define the ABI contract with
>> > >   eventfd_luo_ser structure for serialization.
>> >
>> > Why do you need to preserve this? Why don't you create a fresh one aft=
er
>> > kexec? You just preserve the counter, which looks pretty much useless.
>> > You can just as well open a new eventfd after kexec and set the counter
>> > value if you care about it.
>>
>> Thank you very much for your review and suggestions.
>>
>> My original plan was to integrate KVM with eventfd. Eventfd serves as a
>> critical notification mechanism between guest and host, and it is widely
>> adopted in various scenarios such as networking, file systems, and
>> interrupt handling.
>>
>> At present, however, I have only implemented the preserve and retrieve
>> logic for eventfd, and the integration with KVM has not yet been
>> completed.
>>
>> I have a question and would greatly appreciate your help with it.
>> I have been closely following upstream developments for the liveupdate
>> feature. As I understand it, liveupdate is primarily targeted at cloud
>> virtual machine scenarios. The upstream community has completed the
>> core framework for liveupdate and memfd, and ongoing discussions are
>> focused on state preservation and restoration for VFIO and IOMMU.
>
> Yes that's correct, but that work is to solve some very specific
> problems for virtual machine scenarios:
>
>  1. memfd preservation allows preserving guest memory and userspace
> (e.g. VMM) state in-place across Live Update.
>  2. VFIO/IOMMU preservation allows PCIe devices assigned to virtual
> machines to keep running uninterrupted across Live Update.
>
> I think this series is missing a description of the problem solved by
> preserving eventfds. We don't want to preserve all types of fds just
> for the sake of it. That will bloat the ABI (which will make
> maintaining version compaitibility harder) without any gain.

Yep. I'm not an expert on eventfd/KVM, but from my reading it looks like
it is only a signaling mechanism, and you can set it up fresh after a
live update, before you resume your VMs. There is no state here that
needs to be preserved.

Without a good reason on _why_ the eventfd state needs to be preserved,
I don't think this series should go forward.

>
>>
>> I would like to clarify the following points regarding upstream=E2=80=99s
>> overall roadmap for the liveupdate feature:
>> 1. What is the complete upstream plan for liveupdate?

I don't think there is a single "upstream plan" anywhere. But I reckon
the next few things I have seen people work on are adding support for
VFIO, PCI, IOMMU, guest_memfd, HugeTLB. Maybe TDX or other confidential
compute at some point, though I haven't seen anything concrete about
them.

>> 2. What will the final deliverables look like once fully implemented?
>> 3. Will any new kernel internal interfaces or dedicated userspace tools
>> be introduced?

Who knows, we add kernel interfaces when we see a need for it.

Systemd has recently gained support for live update.

>> 4.  Does the upstream community maintain an official TODO list tracking
>> outstanding work items for liveupdate?
>
> I don't think we have anything comprehensive but there is a ton of
> work to be done if you are looking to help.
>
> A good first step would be to attend the bi-weekly Hypervisor Live
> Update meeting. See
> https://lore.kernel.org/kexec/aiWW6ZwwalqQmVcB@google.com/. The next
> one is on July 13th.

+1

--=20
Regards,
Pratyush Yadav

