Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56539C44523
	for <kexec@archiver.kernel.org>; Sat, 18 Jul 2026 00:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Op9mpgY0d1zSc0ldTUhNOXDVKeO17oxSB/UFy9SPinU=; b=efnS4/RfX4qVWjxiQfXkdZ1vx7
	5Jyz5KMBJatM20Uf2kmko1UeDqK51QFgNUOCaXdLbYhy7wLesr/AP9Imet+HBjxj7sIjeWWmi32ON
	lll7dwVdeCY7foHoxcinoH3HIkCYAlDsD7s5bh15wIiMENqOjOmZ8Wsr91UU5H5lMWtHs6lmw0WuC
	NrsC0YqIrquiNVKW0Od560olIEpp+Hfh7l75QbJYXVj9cZhuBBy4Lbuk6gOJu//jzVcnZmYffgP8x
	Y6AhJU5NdAxCCURo3LjtQhJ2amxCdgY2AGaYGnC86yJVNq/ru6w0xOTPcd48SFP75smH1JWmAzacZ
	hsBZGHFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkt2q-00000003Sam-3rMY;
	Sat, 18 Jul 2026 00:36:44 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkt2o-00000003Sa8-01sy
	for kexec@lists.infradead.org;
	Sat, 18 Jul 2026 00:36:43 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2ccdf36f63dso234735ad.0
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 17:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784335000; x=1784939800; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Op9mpgY0d1zSc0ldTUhNOXDVKeO17oxSB/UFy9SPinU=;
        b=HfCWP6oFmDv29oqZWT4Zmuemhr8EcKyNZugrSK4N9rso+RlaSvlqOsUOFmz+NzL1K+
         n+JlPc+sZcVXiGK+xnXVbFuVMtR5FLLDIFNlwcIO3REUbtDGVEjYDB2WVizjF+iAD/MD
         lIgWzZjTWD/DH8JTiRB55rFa9tpQ5imLMXu4/7IrZDY3SSVdAnRIRLhbxlp4mOA9tTtO
         gB8775dQErSc4TRcIoApilcAPiKSgIE35bO8m4E1Tsfmrm5la63NSKZpEct2VoJnf8Z0
         vD1ULCxJi7IpSdzBdaHTYngYZS6kdY/EsbkM54+fjdxvBjEYqrlBB3NjuqGRuKePSqpK
         AVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784335000; x=1784939800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Op9mpgY0d1zSc0ldTUhNOXDVKeO17oxSB/UFy9SPinU=;
        b=RfwXxFHrFp99QMECWai6S8MmEwOlOf7rC6tknWpjig5HYdfhMlpweYpxBJUdSkqzyB
         nH5k3E74F19fXBlL+xh6plLOZ4j1eXCh4R3Xctf6wXWsDUhyA+HG62EmciXWu/X0O/H3
         lf7LNo/1DNV6k3beRymlrp8UakewlBAx4PDooGaE4KryyOvZV+UIYcG5Z7MfRUqkZy6W
         oQauvWcL42ZvKzKstdBo46Z+x8GxjzIR0QIYaL7Ww2e+khEHZiCfpq8mxxJHr2+HW5dD
         POlM+T/udOZx2b3fjMmLfH0kxqIiSzh8zZjkhshbipgtFx1G0A/VfLhE9k76/tOtFT11
         fj1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp95yZYq+NhdTS9DiuEf006zajaFC2lx0flEdYg5xMw0l03FlxDj9sY85C6ovx0JFFMlq4B9A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy9zzesxaJ9+ah+0DhlgXjurTpJ5pR73oSOSaYUXmFkA9iXjrLR
	iS6Lm4OM1KzCJGjD+Z+pd9mMi66/0jduRtVq/0vwDpcw1hYTy3YslM6z5H3T2k+9pQ==
X-Gm-Gg: AfdE7cm4wfPRlX/VJZZ0S9rrH2jsR5EHKnnok3RIl9JQfz/bMA3KA4+5aMPsVUt8niD
	50XWW01V9GyX9u1eUTmAqYx2DUsuhyo0lGxFrsBSm8aJwReEIFDwpCTaU0fMrs8Ut9JSBpzs4oc
	FCDHAKF6wocZu10P+oa0mFm4Jnw9MKPHcncepeVDp4E6xEVSbwOvzfnF3q1zAtEKml8BnGzySpF
	POPi/CfQZUm1BXAorvoC6CIbTirRw/qt9WECtBJBtib/+Avo/CojWO0BySmBis05yxnm563Q6Ai
	UaRN/GaXx5IbHIDjlbE+A7iEpN42lWEgiq1q+tgE8k1GdEIyl1/v81bderoqNumAr/2k3h4qlv4
	TC9w8hK0OLWmYuZGL5OfC3YP5Xpde1YQFP0ZfaSWmjlx8A4K0hfMSp/irosPnkugQNnpa7hRAKp
	hOAb2Aru3WU2TjteexSkGiELbJIWIDvHoAH+9TI/f+I6xu5WvFdUdHFao2zGMV4SQTi4m2yBiu
X-Received: by 2002:a17:902:f295:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2cf4a34a2f6mr629975ad.1.1784334999258;
        Fri, 17 Jul 2026 17:36:39 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344f61ffsm19120875ad.33.2026.07.17.17.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 17:36:38 -0700 (PDT)
Date: Sat, 18 Jul 2026 00:36:34 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	David Matlack <dmatlack@google.com>, tarunsahu@google.com, open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, "open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] liveupdate: luo_file: Add internal APIs for file
 preservation
Message-ID: <alrDpAMknlYN9jL9@google.com>
References: <20260613012521.835490-1-skhawaja@google.com>
 <20260613012521.835490-2-skhawaja@google.com>
 <2vxzwlvljyzs.fsf@kernel.org>
 <akIask9nPTEAhd76@plex>
 <2vxzse65k938.fsf@kernel.org>
 <2vxz7bnhjnpa.fsf@kernel.org>
 <akvT1yBvIbvft1H_@google.com>
 <2vxz4ihxil6m.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2vxz4ihxil6m.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_173642_088104_FAAE1B17 
X-CRM114-Status: GOOD (  44.37  )
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

On Fri, Jul 17, 2026 at 07:24:17PM +0200, Pratyush Yadav wrote:
>On Mon, Jul 06 2026, Samiullah Khawaja wrote:
>
>> Hi,
>>
>> Sorry I was out of office, so couldn't contribute to this discussion
>> early.
>>
>> On Mon, Jun 29, 2026 at 06:50:09PM +0200, Pratyush Yadav wrote:
>>>On Mon, Jun 29 2026, Pratyush Yadav wrote:
>>>
>>>> On Mon, Jun 29 2026, Pasha Tatashin wrote:
>>>>
>>>>> On 06-26 13:57, Pratyush Yadav wrote:
>>>>>> Hi Sami,
>>>>>>
>>>>>

[snip]

>>>>> Actually, preservation can also be performed in an order-independent manner.
>>>>> While a handler can call liveupdate_get_token_outgoing() during .preserve(),
>>>>> it can also defer this query until the .freeze() callback. Because .freeze()
>>>>> is invoked after all files in the session have completed their .preserve() phase,
>>>>> all dependency tokens are guaranteed to be available, completely eliminating any
>>>>> topological ordering requirements during the initial preservation calls. It is
>>>>> up to individual file handler implementations to decide whether they wish to
>>>>> enforce ordering at .preserve() time or defer it to .freeze().

Quoting this text from pasha below.
>>>>
>>>> That is the worst of both worlds. I get your point that LUO doesn't want
>>>> to enforce dependency ordering. My arguments against that are somewhat
>>>> subjective so I can live with this.
>>
>> Pasha replied with some interesting points already, but I want to add
>> some clarification here.
>>
>> During preservation, enforcing order gives the following functionality:
>>
>> - The token of the dependency (can be retrieved during freeze as you
>>   suggested).
>> - The dependency is preserved and that means it has bound with the LUO
>>   session lifecycle. This guarantees that it is not going to go away
>>   until the session is closed.
>> - Once preserved, the dependency is in some kind of "immutable" state.
>>   This might not be required by all dependent FDs, but it is critical
>>   for some.
>>
>> These ordering requirements should be clearly documented by the
>> associated filehandler so the VMM knows how to do the preservation of a
>> specific FD properly. This is actually similar to the memfd seal rule
>> that iommufd preservation will enforce.
>>>>
>>>> But then you can't let file handlers enforce it as they wish. The
>>>> dependency ordering is uAPI because it directly affects how VMMs
>>>> preserve files. If the VMM has to keep track of dependencies for some
>>>> file types and doesn't have to do so for others, that is a terrible and
>>>> inconsistent API.
>>
>> But as you have already pointed out that the VFIO/IOMMUFD circular
>> dependency is resolved, I am okay with enforcing dependency ordering
>> during restore as well. However, establishing an ordered
>> preserve/restore mandate in LUO at this point will force all future file
>> handlers into complicated and buggy design choices if they have circular
>> dependency or different lifecycle requirements.
>
>Not really. You can always _relax_ the ordering requirements if a need
>does come up. Because all the programs following the ordering will still
>continue to work. The other way round won't work though.

Yes, this is a fair point.
>
>>>>
>>>> Ideally, LUO should handle the dependencies on its own. preserve() can
>>>> give LUO a list of files the preserved file depends on, and LUO makes
>>>> sure all the dependencies are present in the session at freeze. We would
>>
>> This again assumes the lifecycle of various FDs and that dependencies
>> can be resolved during freeze(). Some file handlers do want order of
>> preservation, and this scheme only guarantees preservation dependency
>> without order, introducing hacky dependency state management until
>> freeze().
>>>> also need a way of getting the dependent files back from LUO on
>>>> retrieve(). That would make sure the dependencies are properly enforced
>>>> both on freeze and finish, and the enforcement isn't left up to the file
>>>> handlers.
>>>>
>>>> Unfortunately all that sounds fairly complicated so I am not sure if we
>>>> want to do that just yet, although I would like to hear your thoughts on
>>>> this.
>>>
>>>We had discussion about this in the live update bi-weekly today. The
>>>conclusion we arrived at is to keep the current functionality. That is,
>>>we don't enforce preservation dependency.
>>>
>>>But that also means file handlers can't try to get their dependent file
>>>in their preserve() callback, since that would implicitly enforce
>>>ordering. They always _have_ to do it from their freeze() callback.
>>
>> This has problems at multiple levels:
>>
>> - This indirectly sets up a precedent in uAPI that the VMM is allowed to
>>   preserve the FDs in any order and the file handler will be able to
>>   handle this.
>> - This will be very tricky and will force filehandler to have
>>   complicated/hacky state management to handle dependency. Specifically
>>   I do need iommufd to be preserved before preserving the VFIO cdev that
>>   has an iommufd dependency. Not sure, but I think this will also be
>>   tricky when we start preservation of VFs and SRIOV PFs.
>>
>> I don't think LUO should enforce an arbitrary rule like this unless we
>> have a strong reasoning behind it.
>
>It looks like you, me, and Pasha are saying slightly different things.
>We all first need to take a step back and lay out our proposals clearly.
>I'll write my points down, and I'll try to reproduce what I understood
>from discussions with you and Pasha.

Thanks for laying down your points clearly. I'll reply to point 1 and 3
together as those are entangled I think.

>
>I think we should focus discussions around the below 3 high level topics,
>and we can figure out the implementation details later.
>
>1. Do dependent files need to be preserved before their main files?
>2. Do we apply the same rules to preserve() and retrieve()?
>3. Do the rules apply to all file handler or can file handlers choose
>   their rules?
>
>Here's my take for 1: Say A depends on B. I think it would be a good
>idea for LUO to enforce that B gets preserved before A. You already
>mentioned a few reasons for why. Similarly, LUO should also enforce that
>B gets restored before A. We can figure out where the actual enforcement
>happens, but that would be the principle of the LUO API.
>
>Pasha suggests the opposite. In my discussions, and this email thread,
>he doesn't want to enforce _any_ ordering. So you can preserve A and B
>at any time and you check at freeze() that everything is present. Now I

Just to correct/clarify, quoting Pasha from his earlier email in this
thread:

"It is up to individual file handler implementations to decide whether
they wish to enforce ordering at .preserve() time or defer it to
.freeze()."

Basically, a FH can choose to enforce ordering during preservation or
not enforce any ordering and check it during freeze(). I agree with
Pasha on this point, as it gives FHs the flexibility they need.

However, I see the value in maintaining consistency and simplicity for
the VMMs, we can enforce that dependencies are preserved in order as a
principle of the LUO API. I am ok with this. It might become tricky for
any future circular dependencies down the road, but we can relax this if
they come up, as you suggested above.

>see the value in this idea. It removes the need of tracking ordering
>from VMMs. But I think it is also somewhat dangerous, because what
>happens when freeze() fails? VMMs need to recover and restart the VMs or
>retry live update. I don't know if they would be able to do so. This
>path will likely be less tested.
>
>But still, I can live with that. At least for memfd, guest_memfd, etc.
>this shouldn't be very problematic. I am not sure about iommufd.
>
>So in conclusion, I would prefer to have ordering, but I can live with
>no ordering as well.

As elaborated in my previous email, I disagree with enforcing a
no-ordering policy.

>
>For 2, I think we should apply the same rules on both sides. Mainly for
>consistency. The VMMs should follow the right order for preservation and
>restoration. Now again, I am fine with both enforcing the ordering or
>not enforcing it, but I really think the rules should be consistent
>across both sides.
>
>From my reading, I think Pasha does as well, but from talking with you,
>IIUC you think retrieve is a fundamentally different operation and it
>should not enforce any ordering.
>
>I do see your point but I still think there is value in keeping things
>symmetric. Unfortunately this is fairly subjective, so I don't have much
>better arguments.

I agree with you on this. For consistency and simplicity, we can apply
the same rules on preserve/retrieve both.

>
>For 3, I _strongly_ think it should be a LUO wide policy. Leaving this
>up to file handlers will become messy over time because each would come
>up with its own rules and for VMMs there would be no consistency in how
>they should use LUO.
>
>I hope this helps focus our discussion to the major points. And again,
>we can figure out the implementation details as we go along, so I didn't
>reply to some of the points you raised in this email, to not distract
>too much.
>
>[...]
>
>-- 
>Regards,
>Pratyush Yadav

Also I think with the next revision of this series, if Pasha also agrees
with this, I will add documentation about FD dependency in general.

Thanks,
Sami

