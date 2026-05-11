Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B31CD484A
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 13:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WdZp73JFANv1yjTZ6h8yU8Y68BeneeXC5aWjngszTTg=; b=iWWCMHaSPoauAwQkTG4gUCH0iN
	1wT/lZAnW8/fwJ4EpkYzHHtg787JSZpE/P33Mw9JsHuSdBgFh3G+Ygc8KK9rILLdXxVDz/TEryLbW
	TviJOWIOCkqO2bY63awzHys6zgTbhgcL2OkfhGD548RlViz/wzAAWbsvs0bJ8wd60smYA0fsqvqBk
	JbsTM691MZ6KoedCZkhSMOFJmjUG+5XXUuB2U7ELHHPu9r6w51KjrAvCjZ4+CJjFkbgLOmtqPftGV
	j7znacaJ+TLB+R1o9bOzarJGZVJTCeMdkF29LsuOXRlJNuZRdq3MTcbccecy4u6xWs0Sc6nEeE4zV
	THW3nuww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMQvq-0000000DncJ-2UMd;
	Mon, 11 May 2026 13:44:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMQvp-0000000Dnbo-3rgV
	for kexec@bombadil.infradead.org;
	Mon, 11 May 2026 13:44:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WdZp73JFANv1yjTZ6h8yU8Y68BeneeXC5aWjngszTTg=; b=G00bCfs71U3z45/N/0e0JKnazV
	KjDdQStGS4lL4X6gwvS1Nj8p+/NWtRlnzgYuEfyK45BpHHYN9f5bzU0NFfAUO3Nd/6Z04uqjp/EA6
	UN/PFHry4pjiTZp9z9hu6YP/5B7HHj2YjV2CMrQM4x4Bd/fP9SkvlMrKjzYTISL3CANmX5368NJvJ
	yvRTG+Tc3asZDJjYmMXk3SDIdbG9umUoGdwse4QIMSXfff8CISzTS0XaqHNV4qo3eDGeWetsKkS0j
	/O2zf5K7414FoeXL3oD7BC5+9VFvrCkxgNe3WVdTjtxgg9u/2tn9sNFjFdIjF/Y/AeMnkkphXQXcg
	oQl+yE5A==;
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMQvc-0000000BqFb-0APa
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 13:44:18 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-7bf0b47d2f1so38456327b3.3
        for <kexec@lists.infradead.org>; Mon, 11 May 2026 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778507050; x=1779111850; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdZp73JFANv1yjTZ6h8yU8Y68BeneeXC5aWjngszTTg=;
        b=Y2CNVudoXpzzwhQ9mATNLM/TatOvVJO7Ru4rItmWkia4zAIwCdzNIzpAMjxpQd1h31
         Jdx7ZXpdymYywYOvE0m1eTXtNCaZwVPSY9pD0bOf/xSBI+p98fqT5PXDhdMWBti+EREp
         wAdGank2Ro5dXPdCBfXqvcSt1IdrB96y5gd/KrowQ+vujTctPg8dmzt6TDHlltx5RkSV
         MJfikFQE1aEOBCG7uW3MqEFdbXcIcKGqm0FrGL0ACauS9++DpRBvHd8gYBWcMl7AjjO0
         Qss/LHJ1bpSs3HCjoBk1zrV+7MnZc0vyVQEelYKvJ7VLMwljLzvcBS0dYFpG2Hj86hee
         WPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507050; x=1779111850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdZp73JFANv1yjTZ6h8yU8Y68BeneeXC5aWjngszTTg=;
        b=oqcmjh6LEGWTIEvy2uVBCmDGOR9mU7a6i8Sd/ziLHiwnpNmOyoG9Ha7N5Cjgx0Ho6I
         vE9Rq1vBL9OP6rsn6Ml2LRaIn9QQ6YQIvG2U2CH3Hy5///pkpawODhQIc6XCD0HFxqdZ
         CV3WIts1kkUN/p0bl79IBcMOPQAzwHEP2MI9J1o17Tzs6K04Y31qasuZfF7c0B2gpiqt
         tK++b/cwlzQNeExJW2kjQLnFKW6RsPYbnX/LU//cMuxTa2lS0s1uF+IFNpllj5AQivY3
         j4exseKy7+7zgvtvMZT0I2U8jAE8ksZZhsWg3CqIo4x+UeVOOZbxEhODhacBh6k8PyC6
         mQqg==
X-Forwarded-Encrypted: i=1; AFNElJ8+Ev43jmi/TyLU7V8dkiktAeQXvytcyftZGUpVv2lSGuhmg0/y+dpds1y+S8fH+d+sS4Bb9g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxouTSnS49lsNc1bXuV/gcH/Qh7vkFwqNf/ypUXjgw1jsHdts73
	2x4YJG6tFjdFCOiN0AEXCr7BTiyvGKIKA/rTE0Ao1B1+/doRUieESrcKhiUdzVeQulE=
X-Gm-Gg: Acq92OHpfRc6f11KjBWzjcJc59itxtKbvmhJOs4We6K6WzxZhfOhuBVlYbM2Yyce1I4
	VbOu871fMGDRJpK+BhIWn1+BLB4M2Ei8uaG0jUsHDMeyynq82fi3fR59HX15Q2+I7f44Zs5y96h
	XWS1yAouGos1dlctLprFOv8jFifadfQcyPl6QxZxjez6ls5RN20ahfssgPtMO50ix6RKuiOYGMP
	ybGlKnNRV6WkmyDlEldIXL0Koy784EZCWzBlP+AjvNJeaxjNMvMCJuOXP85efBvtCTxE+atfw8f
	8wmiBbfFO5L3a/rHcMyG2uUb5n4T7hM3a56uTqoRclwMM6QBxCsOswayfI3rh3zZU8OYhStd92B
	s0xtm6UgnIjlDpSTkjWRGRZa52fl9+bSsW7CPqKukjeRVb+nLtrQsrd6hCMM10DoA/3YE/Cu1Sn
	bKUWU5ZxQbLCQ2Pl3T2i+9APzhPzgIeAEQ7CNW9apj7KVBIDMhSAW479iO/gTT1ZehoQMg3Uu1k
	ivIEA2Rdn3dun+V8Xuz9oNHnnXYcPo4uj0ebcNMcJg=
X-Received: by 2002:a05:690c:3482:b0:7ba:eefe:9f9c with SMTP id 00721157ae682-7bfb93b91bfmr134951057b3.23.1778507049874;
        Mon, 11 May 2026 06:44:09 -0700 (PDT)
Received: from google.com (138.200.150.34.bc.googleusercontent.com. [34.150.200.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686ead7sm150263157b3.39.2026.05.11.06.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:44:09 -0700 (PDT)
Date: Mon, 11 May 2026 09:44:08 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, rppt@kernel.org, 
	sourabhjain@linux.ibm.com, jbouron@amazon.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, bhe@redhat.com, linux-kernel@vger.kernel.org, 
	dan.carpenter@linaro.org, rafael.j.wysocki@intel.com, piliu@redhat.com, 
	kexec@lists.infradead.org, graf@amazon.com, changyuanl@google.com, 
	mario.limonciello@amd.com
Subject: Re: [PATCH v2 3/3] liveupdate: block outgoing session mutations
Message-ID: <agHcu9_eSolgNZFT@google.com>
References: <20260506182039.2623553-5-pasha.tatashin@soleen.com>
 <20260506182039.2623553-8-pasha.tatashin@soleen.com>
 <2vxzv7cucint.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzv7cucint.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_144412_550562_C2BFCD4F 
X-CRM114-Status: GOOD (  13.42  )
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

On 05-11 13:03, Pratyush Yadav wrote:
> On Wed, May 06 2026, Pasha Tatashin wrote:
> 
> > During the reboot() syscall, user processes may still be running
> > concurrently and attempting to mutate sessions (e.g., adding files or
> > closing sessions). To prevent this, hold the session header's rwsem and
> > each session's mutex indefinitely on successful serialization.
> >
> > If serialization succeeds, these locks will never be released as the
> > system transitions to the new kernel, effectively blocking any
> > concurrent task attempting to modify or release a session. If
> > liveupdate_reboot() fails, the locks are released in the error path,
> > allowing normal operation to resume.
> >
> > Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
> > Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Sashiko also provided a good comment about this patch: We run over 
MAX_LOCK_DEPTH limit with this patch. I am going to refactor to not take 
every session lock simultaneously during serialization.

> 
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

