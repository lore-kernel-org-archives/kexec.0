Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E662CD4F54
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1GcOO2GPQK8jdA6YOoDMMrcpIA56zbk0ZcDAGkYIqsw=; b=fD8OjZUMDb0nlMDpta47GC4oZp
	J48pJZPaPlVv5SKGIpc41EFQiNjK0lJum9df0opFiBTfiM+d8D2+ycVb3fcODetkHH+HI+x43iTDc
	K3pHYYWcMnV9Jr6Ol/O5Yjpjtc0XJX+gdJueuiTpTw066+DiVq5ONBwflpU7NtEMLgjFX4Pdc9Bq8
	xQIAUwrKDN0VaNpkQdlH+ROPnf1j6rJKMr+SlOTnqCZzXG8oEI7+lEveBLlXvjQBbnobFqgoE1kWs
	y7TEKEXApfpL9hUTp0HahmmBbJihTiL9bDfF2MLKoj0WGMdiGPpav6Bz1Cbt5v4zl0rwG494OEAS4
	aq+nNvpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSHhA-00000004Yz9-45KC;
	Wed, 27 May 2026 17:05:28 +0000
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSHh8-00000004YyL-1SDs
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 17:05:27 +0000
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-914bf8abeaeso427383385a.0
        for <kexec@lists.infradead.org>; Wed, 27 May 2026 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779901525; x=1780506325; darn=lists.infradead.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GcOO2GPQK8jdA6YOoDMMrcpIA56zbk0ZcDAGkYIqsw=;
        b=f+MMx9+CmLRV2UNMN00FVOh8+iwTEG1/iBLHE44by9s1vxbxGKu4q0Nf8JZsC/1gsc
         T2VFG6RJycNgRYKwVXYpLaWZb30kZddn0qf7e+gE9TO/MqX2YgYe+qHHq14V3l17sFFx
         +xZAnqf6UEGh+MS65deFFozG2BJf29f64aaLxI8gCpVIvzJPP5fSXINOgKvEbOYrUL87
         qJEfpkcL/mQpW8tMUD+XqMlvQeARbAanKrz+fyBzRvmhk9YcqtC589s0DAn+p79b2JqO
         zY4i/85/eqeIAHX6p88+1OBYApjjhPjcVeBGdFHrXaCWm3pZxhuGdijZZJH9pcvam7WE
         q8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901525; x=1780506325;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1GcOO2GPQK8jdA6YOoDMMrcpIA56zbk0ZcDAGkYIqsw=;
        b=iGYVfFnWihJyWhA7z5hVsmP3rxhAUfdrCz0Qo4bZpaZ0CyW79LvVLRwgXHA2ud/IqZ
         ncEETX/44eQJO4qLFIfkWVFZxwVZ8yx6qvy1yBRqYPLKM38u74yMFhamtkgHYCA3SWw1
         OIKnwbkWOzuRokHoCt2lFuABlqDBQcSW7cvgNOMOWW98QLmfOGTXoy2vPe/T+UHh70QO
         BsOuPNw1QshPFBQMxThEgEpXgGQDP687sH8cCtfadonQJCex1kuS5clk6wltij7vzbeS
         gK1v2f7YYKvh02bn3/fJV3eFXHKftSwkqdE4925QeGY2X0PctGJOZTO/XCJEeZwGq5Zl
         Td3Q==
X-Gm-Message-State: AOJu0YxUyy5Zs2zPV4m9uRbtodm3ezp80ykyK1JkCpGRjoxlCj1Zf08B
	6t0S5vjClFQ57bUJzao7vs83ACMI1fsB3a9zomYmzgkfoldQLnp9ZDVCz2TO10Cfsp/bJHnWH5A
	qrjoG
X-Gm-Gg: Acq92OG0RuQqDBzDUAFEk2fxDfR4+SkDLhUcWjWFuZV4VF//SvtzDHTL2DSrHf/hdYA
	57K65gXssCDIhifAcXHti7B/nSBqmlbhxE6g0gIGyjr6HAbsa+NFSXCM1j4xiMW8lpjrw2fXL1/
	Lk8L4fWr8Hcuz08Y/P8Vx3OlXLfaIXdY2qhuNQS9Vyy/NupRm07hlJMDY8gWEaIpvkZNzzE0H46
	0yPGiEUIovoWyiv3R17u6GhqKVe6Diu2ebAgatDoYmMdp6Bm5pvbOiCefCu7XDXRXEQAOVnoGN/
	gzuEePKMm7FNr2PhrUUVjH4iboXr/9rz4T5d/Mkzgr0QzdN7P6ppoCYGIWBeUHVPP8K7UH5FUok
	piEddb9oTzy896YMS+xBEh+6KsoOGlPDk//iGxyBMeSkbR0k4RY5SViQ80SbSEXUAJ4VwVTqvCu
	8dZldKEL5AOshieOpzxUdaT4YaJrrkwg0UT89EtYzM7Tnd3YkOzcLIBJJsjc/XMg==
X-Received: by 2002:a05:620a:2a08:b0:914:7b4f:cf5b with SMTP id af79cd13be357-914b48e5b0emr3398167485a.16.1779901524976;
        Wed, 27 May 2026 10:05:24 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86fbce3sm525372285a.11.2026.05.27.10.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:05:24 -0700 (PDT)
Date: Wed, 27 May 2026 17:05:23 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, 
	David Matlack <dmatlack@google.com>, Alexander Graf <graf@amazon.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE/CFP] LPC 2026 Live Update Microconference
Message-ID: <ahcc3Qyuy7Oy03Iq@plex>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_100526_424495_44FAAEDB 
X-CRM114-Status: UNSURE (   7.77  )
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

Hi,

The Call for Proposals is now open for the Live Update Microconference 
[1], taking place at the Linux Plumbers Conference this October 5-7 in 
Prague [2].

As infrastructure scales, minimizing workload disruption during host 
updates has become a critical operational requirement. This 
microconference focuses on the evolving engineering challenges behind 
seamless software handovers, state preservation, and warm reboots that 
bypass traditional hardware reset cycles.

We are seeking technical presentations, and problem statements spanning 
the entire stack—including kexec optimizations, hypervisor integration, 
user-space checkpoint/restore, firmware coordination, and device state 
handovers.

---
A few focus areas we hope to cover during this year's sessions include:
---
 * Orphaned Virtual Machine for zer-downtime upgrades.
 * Live Update Orchestrator (LUO) enhancements and architecture
 * Kexec HandOver (KHO) framework advancements
 * Kexec reboot latencies to minimize guest/workload downtime
 * Preserving guest states across live updates (guest_memfd, hugetlb)
 * In-flight DMA, IOMMU tracking, and preservation
 * VFIO device state preservation and live update migration mechanics
 * PCI/PCIe device handovers, reset avoidance, and state restoration
 * Live Update in Confidential Computing (TDX/SEV-SNP)
 * Building robust testing, fuzzing, and validation frameworks for 
   upgrade paths

---
Submission Details & Deadlines:
---
 * CFP Portal: https://lpc.events/event/20/abstracts/
 * Track Selection: "Live Update MC"
 * Deadline: July 24th, 2026

Session Format Reminder:
LPC sessions are highly interactive working groups, not static lecture 
slots. Proposals should be designed to introduce a concrete technical 
challenge quickly and leave substantial time open for real-time debate, 
consensus-building, and problem-solving with the room. Keep slides 
focused on architecture and open issues rather than heavy text blocks.

We hope to see you in Prague to help push the live update ecosystem 
forward.

(Note: LPC attendance caps fill up exceptionally fast. We strongly 
advise booking your passes early, as track organizers cannot always 
guarantee speaker registration overrides once the event sells out.)

[1] https://lpc.events/event/20/contributions/2321/
[2] https://lpc.events/

Best regards,
Pasha

