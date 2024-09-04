Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E2BCA0ED3
	for <kexec@archiver.kernel.org>; Wed,  4 Sep 2024 10:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YTmB+1+Jy9oFTo6/GBMPLZ3Qt7/5iA3NM/cW12HTdXA=; b=R6EH6SRdT6sP8V
	J5Zrj3q7o/FBDiZzBusdcG3GZf8IeBnhkFLzEv/wN+H84tYxolZe6sNV0L8+M8yb0zUHCiE36Th7t
	sovd0nOZMupBf5iKTjTJgcjtYDTjQDNwxy/pSXBj6aMPTnW3ol1YTpVbk4aN8g5roqFLknKWGfFet
	9NTT5X4MQuHYiCZQLkbOjYlKbgeNo08ttyqgezxBLEXoc4GpfT25/rnpzbyH2wyF6d+eByWWE60+p
	rYaZNJ5ox/7aJt84XNkUPrUg0eYimDjn3/1bxj0kqE2+F12cwf9WEdNKQozR4BIjBZj99ezb6O1I4
	6MxcX6xvdKD37465ncNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slnUH-00000003yJi-1hp1;
	Wed, 04 Sep 2024 10:43:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slnGw-00000003via-1F5z
	for kexec@lists.infradead.org;
	Wed, 04 Sep 2024 10:30:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725445796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GjvrxlJE8EJ7TRDwR1pXnt1cZcb/OYfz99rwQ0Yh7zs=;
	b=S38fUNnlaJ1mk2ofsB66yFuffHB7tyERArbN5GfQ2dB06AFN5JZFcIdZ2mhUpsNYfrwHP9
	l9OKn6W1Dbk7UQeyJA6WuYGqcqURiAY6sA1Y+wYgNbPNeWL4uzkLNoVd9hsecuegSD5JuH
	saouQSAihf+4cQ9bI0Fer+PJjMpGuMg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-KjNqAiOFNe-LS3FPurhPAQ-1; Wed, 04 Sep 2024 06:29:55 -0400
X-MC-Unique: KjNqAiOFNe-LS3FPurhPAQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5a16fae2ba7so420646a12.1
        for <kexec@lists.infradead.org>; Wed, 04 Sep 2024 03:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725445794; x=1726050594;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjvrxlJE8EJ7TRDwR1pXnt1cZcb/OYfz99rwQ0Yh7zs=;
        b=BZvQ6o53nPqmNYuNnVPDnz/BjMrGIUjDJJKGeDTNHYaBcRRWwahWFa7IGZ6EtmivL4
         Lty0Kx9cL+MxcVSfoUxl+mMwPyfZTqTaJfuJLjUhrCyNFe52nfKKeY33d6+bcivZUaFw
         Rd8zcYta+oKg0ULAlhdyePZG+2bQIZnbIfnvFn61DcVjRws4hY1mnC6Rrs4SQrOKgRs9
         dPQP102aaPVmrcOs8f3Y8QOJhP+7KgwMpXAIrEo42vjkemFmSDK1W4uVDkxg6LZ8UMbG
         /mQy1Vztm4QkUEXAvZhgw5tRO0LIE5o3giTJIIU1RB2t9GFC41YMbhZdo+0cIsln1ODL
         S+Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWXSMrjcQqra5cEK5eKn5M8PaMppIaOgTpQDHns0hCRf6VJk1QWIP2qyWf191+wJ/lA8GxZfw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzK2iLZ83pQjV+Oc9LR4+cC/CZ0jkPzFjH8moRHgnoBMemqswoo
	GLM86CuVx+35TddjJfXBsmUCEWq1PNlKyEL+zugzK9zZRLTZE6pc1t+UwMIDteVHdN5lg6KpyJh
	8hzAZ/Qjz3Y28DtEkBJRbOjLPLjRROkGP5qfFQ17JsVj6hKWH/jayi5rytA==
X-Received: by 2002:a05:6402:1ec5:b0:5a1:24fc:9a47 with SMTP id 4fb4d7f45d1cf-5c2caf22be6mr1560653a12.27.1725445793836;
        Wed, 04 Sep 2024 03:29:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlfGqHgiFwjp/Ap4TY3x8/1uxKWyFR9NEI0cj9enurEW6F7gDBRXOrJY/rHX0K4XiDL+Ug+g==
X-Received: by 2002:a05:6402:1ec5:b0:5a1:24fc:9a47 with SMTP id 4fb4d7f45d1cf-5c2caf22be6mr1560599a12.27.1725445792849;
        Wed, 04 Sep 2024 03:29:52 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c250edd2e3sm4341769a12.27.2024.09.04.03.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 03:29:51 -0700 (PDT)
Message-ID: <25ca73c9-e4ba-4a95-82c8-0d6cf8d0ff78@redhat.com>
Date: Wed, 4 Sep 2024 12:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/sev: Fix host kdump support for SNP
To: "Kalra, Ashish" <ashish.kalra@amd.com>,
 Sean Christopherson <seanjc@google.com>
Cc: dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, thomas.lendacky@amd.com,
 michael.roth@amd.com, kexec@lists.infradead.org, linux-coco@lists.linux.dev
References: <20240903191033.28365-1-Ashish.Kalra@amd.com>
 <ZtdpDwT8S_llR9Zn@google.com> <fbde9567-d235-459b-a80b-b2dbaf9d1acb@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <fbde9567-d235-459b-a80b-b2dbaf9d1acb@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_032958_457911_2B529B04 
X-CRM114-Status: GOOD (  18.22  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 9/4/24 00:58, Kalra, Ashish wrote:
> The issue here is that panic path will ensure that all (other) CPUs
> have been shutdown via NMI by checking that they have executed the
> NMI shutdown callback.
> 
> But the above synchronization is specifically required for SNP case,
> as we don't want to execute the SNP_DECOMMISSION command (to destroy
> SNP guest context) while one or more CPUs are still in the NMI VMEXIT
> path and still in the process of saving the vCPU state (and still
> modifying SNP guest context?) during this VMEXIT path. Therefore, we
> ensure that all the CPUs have saved the vCPU state and entered NMI
> context before issuing SNP_DECOMMISSION. The point is that this is a
> specific SNP requirement (and that's why this specific handling in
> sev_emergency_disable()) and i don't know how we will be able to
> enforce it in the generic panic path ?

I think a simple way to do this is to _first_ kick out other
CPUs through NMI, and then the one that is executing
emergency_reboot_disable_virtualization().  This also makes
emergency_reboot_disable_virtualization() and
native_machine_crash_shutdown() more similar, in that
the latter already stops other CPUs before disabling
virtualization on the one that orchestrates the shutdown.

Something like (incomplete, it has to also add the bool argument
to cpu_emergency_virt_callback and the actual callbacks):

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 340af8155658..3df25fbe969d 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -111,7 +111,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
  
  	crash_smp_send_stop();
  
-	cpu_emergency_disable_virtualization();
+	cpu_emergency_disable_virtualization(true);
  
  	/*
  	 * Disable Intel PT to stop its logging
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0e0a4cf6b5eb..7a86ec786987 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -558,7 +558,7 @@ EXPORT_SYMBOL_GPL(cpu_emergency_unregister_virt_callback);
   * reboot.  VMX blocks INIT if the CPU is post-VMXON, and SVM blocks INIT if
   * GIF=0, i.e. if the crash occurred between CLGI and STGI.
   */
-void cpu_emergency_disable_virtualization(void)
+void cpu_emergency_disable_virtualization(bool last)
  {
  	cpu_emergency_virt_cb *callback;
  
@@ -572,7 +572,7 @@ void cpu_emergency_disable_virtualization(void)
  	rcu_read_lock();
  	callback = rcu_dereference(cpu_emergency_virt_callback);
  	if (callback)
-		callback();
+		callback(last);
  	rcu_read_unlock();
  }
  
@@ -591,11 +591,11 @@ static void emergency_reboot_disable_virtualization(void)
  	 * other CPUs may have virtualization enabled.
  	 */
  	if (rcu_access_pointer(cpu_emergency_virt_callback)) {
-		/* Safely force _this_ CPU out of VMX/SVM operation. */
-		cpu_emergency_disable_virtualization();
-
  		/* Disable VMX/SVM and halt on other CPUs. */
  		nmi_shootdown_cpus_on_restart();
+
+		/* Safely force _this_ CPU out of VMX/SVM operation. */
+		cpu_emergency_disable_virtualization(true);
  	}
  }
  #else
@@ -877,7 +877,7 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
  	 * Prepare the CPU for reboot _after_ invoking the callback so that the
  	 * callback can safely use virtualization instructions, e.g. VMCLEAR.
  	 */
-	cpu_emergency_disable_virtualization();
+	cpu_emergency_disable_virtualization(false);
  
  	atomic_dec(&waiting_for_crash_ipi);
  
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 18266cc3d98c..9a863348d1a7 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -124,7 +124,7 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
  	if (raw_smp_processor_id() == atomic_read(&stopping_cpu))
  		return NMI_HANDLED;
  
-	cpu_emergency_disable_virtualization();
+	cpu_emergency_disable_virtualization(false);
  	stop_this_cpu(NULL);
  
  	return NMI_HANDLED;
@@ -136,7 +136,7 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
  DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
  {
  	apic_eoi();
-	cpu_emergency_disable_virtualization();
+	cpu_emergency_disable_virtualization(false);
  	stop_this_cpu(NULL);
  }
  

And then a second patch adds sev_emergency_disable() and only
executes it if last == true.

Paolo


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
