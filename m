Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3C7EA719F
	for <kexec@archiver.kernel.org>; Sun, 19 Apr 2026 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FVSK+fsISPqluFRtt7h7ZDht/v+GA+OlOcuuAUGLOY8=; b=Rf4TOGgGZDzv16MEk2xwEnSb19
	WyMeK4eZlHViVbKTEUKUERgmj06pZNzVHQY1s6v21s+PWAZJJAfxeGKOqdEy1lbJckolm6EPF9Emc
	d6IkePqf7JeZMo9YlQTR/OFkeVxTxF/fvllnixULHesm6KpGA1d78bh939zaEHCeZyoMlYii4aMK7
	oWdUCrgMq1glR9x9wFhDvJ0W5ehrGrV7iuvfiUGXwrhp4uS0SYCIqjViOLCVXfxogsVmFGUci1xLf
	B1mUjFj9O8fSMfAc25zK3Kw8/IkRFhdpqvJKJaqnk8DtiG6R8RrxGpgBs2RYgOcBlWLLoyU4sLCv0
	QNjqLc8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wETpL-00000005sfg-0Wox;
	Sun, 19 Apr 2026 15:12:51 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wETpH-00000005sex-3YLX
	for kexec@lists.infradead.org;
	Sun, 19 Apr 2026 15:12:48 +0000
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-8d67a483d3eso251822185a.1
        for <kexec@lists.infradead.org>; Sun, 19 Apr 2026 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776611567; x=1777216367; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVSK+fsISPqluFRtt7h7ZDht/v+GA+OlOcuuAUGLOY8=;
        b=C1N3rWJSAsQlWv5s6hi0hM1DoVYnm0ryxhsUniUgp6hLk/3OB33ktKOJizTuCnR41s
         M2EzuusxH+8KSGY+vxHrdOtxVBN4UMoKLbjFj30cCpHmvQINjcO9QkkxAQoFyhOJ2HAH
         t97xfxORlrxs19izjCCXL8UttVhprqZza8wtwT82k48p4HVMzLtrO0NNPIddcAZ0yO8u
         e7xOvsnGqdxGLs4iVSSruRziltroU+BOGPsGroBiSDYxPpNtkPud1s/Q3TIttsd2mjW3
         0k8sXHIiyQJvim+cYMp675NIPaRfLUyOGlBFHwgP71byvIldFd/oh4vN1q93TNf9ynxr
         e4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776611567; x=1777216367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVSK+fsISPqluFRtt7h7ZDht/v+GA+OlOcuuAUGLOY8=;
        b=rGuMKAoUh367YYiKPJ2ra8GjOflAm71cKNGweSIaOVNWtgltRmNbiMwzomNImo+MP8
         atZLpBd6GiwVcJdGkHWdtRPEpP2ht92B9QKLZ6F/JRlO3Zlj2FSmqSvw8RpQYQc0kry3
         MZH/2E+ohTJg8uVExtOZ7jTebxY8E8PqpRiPXklHUoYAla9zvOSnLHAx3tRp83qc21Os
         S4Aj40hnyQXEtoWCRiFrvfe+Kx/ear0znpFy+3NEdUoD6uAxrxqsrnCMUUhNEpUjJ0OM
         6NkXkzGKEmyGHA42fidRdX2OPLtTlxhq/rzbbwbVV/mPMJs38c24TEY7g7QpSIyj5vO1
         aWGA==
X-Gm-Message-State: AOJu0Yy4NCRoJhC6vM6D5YwyRc/cAtmoKpZJvM8F0ORuxJzwoAziB8J9
	4Buj0rIZwfDcO7CYgczDqjRgpX03MVv6sF/oR6X/4J2pDthV3eQqLYY2GmOyHIf8aWM=
X-Gm-Gg: AeBDiev5OjqXzAlZ4dxYw4PSB1BV2YFdMchzd5X1UGOUBup9aG1i3LzvC95CDFpkMLQ
	+eaDW48Y5KqUYrDqh0lkWLq/eZORt9icJ84nsf8dLm6zTz9uNY9B7Kdqc2jY+BhBs06WJyoyXyF
	1u7j/S7oSryrhk78CiSSnid/V9b86E9HaP/9lKwvvT/kQaDWHeUNpZ/rIYRh5F66tF1G8gtJudK
	Fu5Z+0COWGgXaqKQJYGGsVou/NcSL8zq5/Y7wlyn13bt95aS/0YBxYMOjRt4xSQl6U8KFwx40y/
	yOrBi0uELnHYoMMVrqubhhia80jIgIEkI7PsOFVnntm7xNjsYVmhnZsIfC9FZ0yP7W6RqaNUUYY
	0xlFBdmdUVeJqAYakaIKjLXvDQafVvKDn4k92RENBSiBvGiMoNUgqfsOhCToL1/xFF16CtjysgB
	7M1gQhGfRrmHaWgF5l2UK3o1TSoDB8txr3y0/s0Aw8VNm6KM8AIJBej6/iymRuieY89znCnTw=
X-Received: by 2002:a05:620a:4015:b0:8cf:dd93:acbe with SMTP id af79cd13be357-8e79040e2e0mr1477924585a.24.1776611566564;
        Sun, 19 Apr 2026 08:12:46 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69ae320sm681290985a.20.2026.04.19.08.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 08:12:45 -0700 (PDT)
Date: Sun, 19 Apr 2026 15:12:43 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	brauner@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/6] selftests/liveupdate: add test cases for
 LIVEUPDATE_SESSION_GET_NAME
Message-ID: <w2z3mt3ghjmcejgzg75hsgoahvmzrlj5jls4etbm4z27mtnzgr@yldyrgmjzul5>
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
 <20260418163358.2304490-7-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418163358.2304490-7-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260419_081247_907592_99883108 
X-CRM114-Status: UNSURE (   6.76  )
X-CRM114-Notice: Please train this message.
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

On 04-18 17:28, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> Verify that the new LIVEUPDATE_SESSION_GET_NAME ioctl works
> as expected via new test cases in the existing liveupdate selftest.
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

