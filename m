Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CBDCD37B0
	for <kexec@archiver.kernel.org>; Mon, 18 Sep 2023 15:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0reoppp4kx1DJ8QXXAw4Wg2jgz2aVL8S0Jw0iFetl24=; b=2RHxthAGPVxDEl
	2JYl3QfZf4T0lp2M6y5ZHTZocEFlYCCXCFhrT/TAtEiowqRBG0hQqMYtVVMaoaBBr27qvP4p3SUI8
	8GkSo1iurjGyzLuutXuQE6PPbb/OzSveselFbQDgzJyrIz/2NpJtNtHpejieV/Ip8I1mszYSkH1hx
	auR4qibT/CGE3PlJg9ZVwHScMOWlHmIbwIKVWapPfr7VNzdFJcs6m9uCuUv9OKdsjgPma0kdHjsGb
	/qikMbrsIIJ8AvvHD6pHVDZrZXgxw7O2M8OXKpTqKVJKNeiT3LDioc5m46PHtvZRuMp4qbCSE5hZ8
	9+PyaOykboDPr7y1L73g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiGIW-00FlpG-2w;
	Mon, 18 Sep 2023 15:36:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiGIT-00Flnx-0a
	for kexec@lists.infradead.org;
	Mon, 18 Sep 2023 15:36:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695051383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vr7GWd2VoXZupzZUaxFhlqO+6Z35WiBMgeAjc66b/jQ=;
	b=GYcf+NCUlwRiKSfVKa9IM8xpSJkrL9H3JVm5MHVRvOfgOtaZBcvz9YAFYNs9HZmx7dOEtA
	vE+WPYztuVAIpAq4sH0UcnCPiCOwmvIYQWv6psfTaQKtjZy//4airj4mA/Q6QyHLT4Z5s1
	PO+8T8Qu/led3WATwF1eREWLlnJwnWs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-sWxOBnh2MdiRMkc-uzAlkw-1; Mon, 18 Sep 2023 11:36:21 -0400
X-MC-Unique: sWxOBnh2MdiRMkc-uzAlkw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07C4E3800EA0;
	Mon, 18 Sep 2023 15:36:21 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.193.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB075492B16;
	Mon, 18 Sep 2023 15:36:13 +0000 (UTC)
Date: Mon, 18 Sep 2023 17:36:07 +0200
From: Philipp Rudo <prudo@redhat.com>
To: "Jan Hendrik Farr" <kernel@jfarr.cc>
Cc: "Lennart Poettering" <mzxreary@0pointer.de>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
 tglx@linutronix.de, dhowells@redhat.com, vgoyal@redhat.com,
 keyrings@vger.kernel.org, akpm@linux-foundation.org, "Baoquan He"
 <bhe@redhat.com>, bhelgaas@google.com, "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Message-ID: <20230918173607.421d2616@rotkaeppchen>
In-Reply-To: <0e1984af-88ca-4908-a5ca-3191d96aa63f@app.fastmail.com>
References: <20230911052535.335770-1-kernel@jfarr.cc>
	<20230913160045.40d377f9@rotkaeppchen>
	<ZQLTJFb3S/xn5CWo@gardel-login>
	<20230914205149.51031bc9@rotkaeppchen>
	<0e1984af-88ca-4908-a5ca-3191d96aa63f@app.fastmail.com>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_083625_292964_F16335D8 
X-CRM114-Status: GOOD (  34.27  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Jan,

On Thu, 14 Sep 2023 23:04:32 +0200
"Jan Hendrik Farr" <kernel@jfarr.cc> wrote:

> On Thu, Sep 14, 2023, at 8:51 PM, Philipp Rudo wrote:
> > [...]
> >
> > In this context I hope it is also clear to you that when more and more
> > people rely on the spec you need a more formal process when including
> > changes. Especially when the change might break the implementation of
> > others. So no more making the .cmdline optional and allowing it to be
> > overwritten all on the same day.
> >
> > Having that said, what does "local override" exactly mean? Does that
> > mean a distro can allow a user to freely choose the cmdline without
> > checking any signatures?  
> 
> The behavior of systemd-stub is to allow the bootloader (or whatever
> called sd-stub) supplied cmdline when there is no .cmdline section in
> the UKI. That's how I understand "local override" here. For WIP v3 of
> this patch the behavior is to use the cmdline supplied by userspace to
> the kexec_file_load syscall if no .cmdline section is in the UKI.
> 
> empty .cmdline section -> empty cmdline always passed to kernel
> .cmdline section -> use bootloader/user supplied cmdline (which would
> be empty by default)
> 
> This setup does not make sense for a locked down / secure system though.
> 
> Maybe the word "override" is not ideal. There is nothing actually being
> overridden as there is no cmdline in the UKI in the first place.
> 
> sd-stub also allows the bootloader supplied cmdline if not using secure
> boot. So maybe the kernel could allow user supplied cmdline if not in
> lockdown mode for kexec maybe? If not in lockdown mode somebody can just
> kexec an unsigned kernel + unsigned cmdline using the kexec_load syscall
> anyways. For this case the word "override" makes sense.
> 
> The logic for all of this in sd-stub is in [1].
> 
> > I.e. does that mean we can get rid of this
> >      https://github.com/systemd/systemd/issues/24539  
> 
> This is a different usecase IMO.

Yeah, I expected that. The whole question was meant to be rhetorical.
The point I wanted to make was that when a spec uses terms like "local
override" it needs to explain what it means.

Thanks
Philipp

> >> Hence, seeing the spec as set in stone and as inherently low quality
> >> is the wrong way to see it I am sure. Instead, the goal here is to
> >> adjust the spec to make it work really nicely for *both* systemd and
> >> the kernel.  
> >
> > Sorry, I never wanted to intend that the spec inherently low quality.
> > Just that it doesn't meat my expectations, yet. But that is fine. The
> > spec isn't even a year old and there's only a single implementation,
> > yet. So it's more documentation rather than a spec.  
> 
> Let's make it happen.
> 
> 
> [1] https://github.com/systemd/systemd/blob/5898cef22a35ceefa068d5f46929eced2baab0ed/src/boot/efi/stub.c#L140
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
