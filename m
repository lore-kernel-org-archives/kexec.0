Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CB6C43458
	for <kexec@archiver.kernel.org>; Mon,  6 Jul 2026 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LAhwznhf5DkVP4v3gs3lqPrh/lcXm4gQZUhW/MOasno=; b=IbAKQwHgBz/1hV+ItmnNlVj+S0
	AmFaXBhTDsikdjOLjvqe3j1OPC3Tv9X4wcN7HezjlRU/bTPFJTHDiF0CaZ/zoDgdac6MdcqMPgzZ6
	p4vu6hVx8cvVCqDPTfM57uCE3Owk6uSV54HkOIC6qzZkwtqQdyBq0fZ4Z4REoANg9sL4qYIXrY9BI
	BSwRHlg2fjhvWoxun0/BQnYw4jD7yyvOnoBE/Twp+hG9NKlFXAlvuQGkCpccRq64xB0Gso9Owi3H7
	vbONedBh2pxootLjT/6UutQms4Wd+IRt3qMD9Crs3+ENHj/waIF90PGI4jc814I76rRKLs19Lubfa
	AMN23NQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgpU9-0000000DWKT-2lLt;
	Mon, 06 Jul 2026 20:00:12 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgpU4-0000000DWEq-0uMh
	for kexec@lists.infradead.org;
	Mon, 06 Jul 2026 20:00:07 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2cacef7d299so13445ad.1
        for <kexec@lists.infradead.org>; Mon, 06 Jul 2026 13:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783368003; x=1783972803; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LAhwznhf5DkVP4v3gs3lqPrh/lcXm4gQZUhW/MOasno=;
        b=JDb4ISs9Q/1kgvGwPFqh9Hie5QdRW9r/0xzdEp75x//DDoGGAKiukuRiA3xVP2iQl4
         qfuitwAOegnVmV1bkIwx6ezqR0pUE/H+rXsojclKXXPa6bGo3HCl/A0Hmnb4x8nHz93i
         KgGpQ/4qPGGKIs+696+KQYe4jUPByg79T0tlTOpbjkW7TsgebMf65/rRKUhPCw0wmySB
         KKA+UNfpxGdOGh0oTyDL5Q6cQHu05crYcUQ48SBFU7g0zWhkCl4fOb97GA0kqfjM2HwV
         Zt6BIzvIuT8THhIoM8B/sEXWFU/WtCRBgbcMSWJl73bxJ8XI+5ze42vifOqA021vklT0
         QNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783368003; x=1783972803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LAhwznhf5DkVP4v3gs3lqPrh/lcXm4gQZUhW/MOasno=;
        b=ChJKtQgkv21XysMY49wnufLxtifWC5QwY42CEKy3YmF79mBhJFGn6Nq/V1rIiVThj4
         WK9/2NWUBgsdHkVN19F76kSJb5Ldh4iuInlJI457Ul9QN57tMsYeKQcnCFbA3kLzPRfY
         sh7CpLFBfQd1OWwLcFsq70Uz5mscm6sNkVU9GWeFGkfgFBxmE73W18bFvWIRYYPYPzCY
         aSdmwG0/5S4/Z/RDFI4sO7pMYU6QaGLMbwJtLmHCtSks2omBwJS7eNKpIgWNlmFHTePD
         moHkpSBEoFCtwOWsuBUEWq9iRCqf4xI3i8D3IqyKnpttLO44TmF280Yfo9LYFTgezXZm
         BTjw==
X-Forwarded-Encrypted: i=1; AHgh+Rof6K+p+2zLrgoT8kF3r/jbH5xE4+AKfDCquFOaPvTKVVJDFAow4nIXi/aXlYi0ooMiMBVJ4g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzwaKtnErZQS4SA30rRSEqBZl+AmDJ9VsvJh6G9WCRVUSnmBR7C
	fXIFdPuNcDfDL9msytNqbRlpzA8fMqlmvu4I4MxyNhsIZiNH5+Ia48oBOh+KN/Nglw==
X-Gm-Gg: AfdE7cmr0BOkeKzIGUbXngjYk0HYSd0RCetsf1ghXElHuhK+RT8+kvjiiDGPJJeL+0+
	GqzFONtEUCHeFjMfcdSJDVPrDfpeyHGC3sKHO1aVm06Yf3BwoRb71H6bnIBKb9wcK6DmVqyNOQv
	d+ZyF+TQlxxIz/3i2dSgcIRwhxWy/b78/nuEEd5ASRT7YEsHiJzZiW/3OjUDfT9JpaGimsRixJf
	nYP/VyWiHUIVxSEd64H708VRlS2zvmJdjCsgcjzIapHdmNvyaGcvufk14oYTkw9p9KtEbFIFO13
	O15t9L9Z28PQ4lkZkACzSHhQ/7suxWyEm9Fui/F1XZ4utMPc2pEC/iwlraeRsEx9iJ8pK+6K4DC
	PMw3csQywnsFrO162RZ97mm9bCaZ4Vwm9nNceGGuKKhHXy+f9Isnb4jqxMBXOB1gM0MaFHd7bet
	I9udwob5IBr3BmJUWbG1psfOD9dwCGFSi9aM+7g25v4/wKA0KMDo8/p+PyaI5ZpUlgilSQqFZO4
	TyllP7UrWM=
X-Received: by 2002:a17:903:41cf:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2ccc71c1939mr447305ad.1.1783368002032;
        Mon, 06 Jul 2026 13:00:02 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b609b8sm4361747b3a.5.2026.07.06.13.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 13:00:01 -0700 (PDT)
Date: Mon, 6 Jul 2026 19:59:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	David Matlack <dmatlack@google.com>, tarunsahu@google.com, open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, "open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] liveupdate: luo_file: Add internal APIs for file
 preservation
Message-ID: <akvT1yBvIbvft1H_@google.com>
References: <20260613012521.835490-1-skhawaja@google.com>
 <20260613012521.835490-2-skhawaja@google.com>
 <2vxzwlvljyzs.fsf@kernel.org>
 <akIask9nPTEAhd76@plex>
 <2vxzse65k938.fsf@kernel.org>
 <2vxz7bnhjnpa.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2vxz7bnhjnpa.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_130004_307989_C18A6456 
X-CRM114-Status: GOOD (  38.99  )
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

Hi,

Sorry I was out of office, so couldn't contribute to this discussion
early.

On Mon, Jun 29, 2026 at 06:50:09PM +0200, Pratyush Yadav wrote:
>On Mon, Jun 29 2026, Pratyush Yadav wrote:
>
>> On Mon, Jun 29 2026, Pasha Tatashin wrote:
>>
>>> On 06-26 13:57, Pratyush Yadav wrote:
>>>> Hi Sami,
>>>>
>>>> On Sat, Jun 13 2026, Samiullah Khawaja wrote:
>>>>
>>>> > From: Pasha Tatashin <pasha.tatashin@soleen.com>
>>>> >
>>>> > Live update orchestrator file handlers depend on the preservation of
>>>> > other files. To make sure that the dependency is preserved, the file
>>>> > handlers needs to fetch the preservation token of the preserved
>>>> > dependency. Similarly during restore, a file handler wants to fetch the
>>>> > restored file of the dependency.
>>>> >
>>>> > Add APIs that allows fetching token of dependency during preservation,
>>>> > and fetching the restored file dependency during restore.
>>>> >
>>>> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>>>> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>[...]
>>>
>>> To achieve this, LUO provides the .can_finish() callback. So, LUO does
>>> two-phase verification:
>>>
>>> 1. It iterates through all tracked files and invokes .can_finish().
>>> 2. Only if *all* files return success does it proceed to invoke .finish().
>>>
>>> If a VMM restores a file (such as guest_memfd) but fails to restore its
>>> dependency (such as the VM FD), or attempts to close the session
>>> prematurely, the .can_finish() check for that file will fail (returning
>>> -EBUSY), and the entire finish sequence will abort. This guarantees
>>> kernel-enforced correctness at the session boundary and without forcing
>>> the VMM to execute restores in a strict sequential order, which anway
>>> would not make  any sense from kernel side due to circular dependecies
>>> issue, where topological sort does not exist.
>>>
>>>>
>>>> But on the preservation side, VMMs still do need to follow the
>>>> topological order of dependencies. Because if they don't, the
>>>> liveupdate_get_token_outgoing() call will fail and preservation can't
>>>> proceed.
>>>
>>> Actually, preservation can also be performed in an order-independent manner.
>>> While a handler can call liveupdate_get_token_outgoing() during .preserve(),
>>> it can also defer this query until the .freeze() callback. Because .freeze()
>>> is invoked after all files in the session have completed their .preserve() phase,
>>> all dependency tokens are guaranteed to be available, completely eliminating any
>>> topological ordering requirements during the initial preservation calls. It is
>>> up to individual file handler implementations to decide whether they wish to
>>> enforce ordering at .preserve() time or defer it to .freeze().
>>
>> That is the worst of both worlds. I get your point that LUO doesn't want
>> to enforce dependency ordering. My arguments against that are somewhat
>> subjective so I can live with this.

Pasha replied with some interesting points already, but I want to add
some clarification here.

During preservation, enforcing order gives the following functionality:

- The token of the dependency (can be retrieved during freeze as you
   suggested).
- The dependency is preserved and that means it has bound with the LUO
   session lifecycle. This guarantees that it is not going to go away
   until the session is closed.
- Once preserved, the dependency is in some kind of "immutable" state.
   This might not be required by all dependent FDs, but it is critical
   for some.

These ordering requirements should be clearly documented by the
associated filehandler so the VMM knows how to do the preservation of a
specific FD properly. This is actually similar to the memfd seal rule
that iommufd preservation will enforce.
>>
>> But then you can't let file handlers enforce it as they wish. The
>> dependency ordering is uAPI because it directly affects how VMMs
>> preserve files. If the VMM has to keep track of dependencies for some
>> file types and doesn't have to do so for others, that is a terrible and
>> inconsistent API.

But as you have already pointed out that the VFIO/IOMMUFD circular
dependency is resolved, I am okay with enforcing dependency ordering
during restore as well. However, establishing an ordered
preserve/restore mandate in LUO at this point will force all future file
handlers into complicated and buggy design choices if they have circular
dependency or different lifecycle requirements.
>>
>> Ideally, LUO should handle the dependencies on its own. preserve() can
>> give LUO a list of files the preserved file depends on, and LUO makes
>> sure all the dependencies are present in the session at freeze. We would

This again assumes the lifecycle of various FDs and that dependencies
can be resolved during freeze(). Some file handlers do want order of
preservation, and this scheme only guarantees preservation dependency
without order, introducing hacky dependency state management until
freeze().
>> also need a way of getting the dependent files back from LUO on
>> retrieve(). That would make sure the dependencies are properly enforced
>> both on freeze and finish, and the enforcement isn't left up to the file
>> handlers.
>>
>> Unfortunately all that sounds fairly complicated so I am not sure if we
>> want to do that just yet, although I would like to hear your thoughts on
>> this.
>
>We had discussion about this in the live update bi-weekly today. The
>conclusion we arrived at is to keep the current functionality. That is,
>we don't enforce preservation dependency.
>
>But that also means file handlers can't try to get their dependent file
>in their preserve() callback, since that would implicitly enforce
>ordering. They always _have_ to do it from their freeze() callback.

This has problems at multiple levels:

- This indirectly sets up a precedent in uAPI that the VMM is allowed to
   preserve the FDs in any order and the file handler will be able to
   handle this.
- This will be very tricky and will force filehandler to have
   complicated/hacky state management to handle dependency. Specifically
   I do need iommufd to be preserved before preserving the VFIO cdev that
   has an iommufd dependency. Not sure, but I think this will also be
   tricky when we start preservation of VFs and SRIOV PFs.

I don't think LUO should enforce an arbitrary rule like this unless we
have a strong reasoning behind it.
>
>Similarly, on retrieve side, file handlers enforce their dependent files
>are restored via the can_finish() callback only.

Please elaborate: does this mean the file handler cannot fetch the
restored struct file of its dependency until can_finish()?

This would actually be worse. A filehandler that needs to take a
reference to its dependency during its own init phase would just fail to
restore. For example, it means the vfio cdev cannot auto-bind with the
iommufd until can_finish() is called.

Also can_finish() is called just before LUO finish phase, and that is
already too late. The FDs should be restored and ready to finish at that
point. Forcing the dependent to resolve/enforce dependencies during that
means the dependent FDs are half baked before that?

Again let's be careful about enforcing arbitrary rules like these in
LUO, because these end up defining uAPI and lifecycle rules that we
cannot change later.
>
>So I think the next steps for this series is to clearly document this
>requirement for file handlers in the documentation for
>liveupdate_get_token_outgoing() and liveupdate_get_file_incoming().
>
>Also, I think you need some way of tracking if the file was explicitly
>restored by userspace, which is something file handlers would then need

I think we should add a mechanism like this regardless. This will allow
file handlers like guest_memfd (if they determine it is necessary) to
verify that userspace explicitly restored their dependencies, without
forcing the ordering policy globally on everyone else.
>to call in their can_finish().
>
>[...]
>
>-- 
>Regards,
>Pratyush Yadav

Sami

