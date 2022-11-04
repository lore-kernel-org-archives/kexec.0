Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54016C433FE
	for <kexec@archiver.kernel.org>; Fri,  4 Nov 2022 11:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sfn0YmVHs2sWsSULt61Ml4GbcYtSxY0+t7sUQFxcJSE=; b=NIDhcaZKJQA8Lf
	7L8SFm96w+erL4NEUh2E5A5QN03r/2zDqxCMnKV8w7YEZPZ3ueeyY2aOHgdDliztmslTuwBx7Qvvv
	YjmFneLknbNYhqFiLqgPiCuBax3fOrqEryY1f2j+6ygUUxYrsmc/DazS2oLqeDcBBWUGcUeT79JfI
	dxtrSCTVIfI/9cJQcuSuaF8usMKlVYWMX73b27tg8Xe4clwnXLKPdB+4UFzI1u2dBd6j2YDHd1Qar
	e0J5E6wJVfKw6o/Y1a1fG/LugIXq9/lt26/R3MFIwI3/RPLsWkADihbcn0MIsAT4jNDEXLcJmUsK9
	rdeqv3SUN6aGrBjHy4Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oquvg-003M48-I4; Fri, 04 Nov 2022 11:32:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oquvb-003M29-FU
	for kexec@lists.infradead.org; Fri, 04 Nov 2022 11:32:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667561521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X2vF9wu9D9A9HBRSXFDC1P9Ez4nhQcXyZNLm0dcpRMo=;
	b=Wc7xhb6m6iFUvMY28qlTSu1QouM4cBi/MStuUIq164fg6JALBuPtb1mLuREitZIdNmzHOL
	97RdrW6gPxxzLKB2Nzm68eWgAqz0Tm0L+GSFK9iscqX0a5wS/mv4BhN89N9SspCi4rFbRi
	ir4avBkK+HcKdwLfTRqzxqy8G2OTly8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-571-JaFPJjvDNKa3NOJPdOrhiQ-1; Fri, 04 Nov 2022 07:30:11 -0400
X-MC-Unique: JaFPJjvDNKa3NOJPdOrhiQ-1
Received: by mail-pl1-f198.google.com with SMTP id c1-20020a170902d48100b0018723580343so3417759plg.15
        for <kexec@lists.infradead.org>; Fri, 04 Nov 2022 04:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2vF9wu9D9A9HBRSXFDC1P9Ez4nhQcXyZNLm0dcpRMo=;
        b=7wASV5BeJU3lVOhFwklZ/moTzDOosb/Pikp1urDyDaAOTp6uWoMgko/Tk5LVvbpWyt
         kBTlNEvbL6qM6l6LkY6iue185q7oinYvpYWmsykKO9hzjse57FJDCCYtHT84iBRBc0OB
         2E1TnjwTXgV/npp6zn5N5TGnjDHXbZxSbHgxEKczasoOuss7IYRdBY75gCGAcibolthY
         bTv6qpB1Rvt79gSDwC7Omo5ufq9coxsKECVGwSuVbbI2Oxz9+NfJgykFgRhamGghCi/m
         DUpGIyQAcXtLcOU9oP42qHrT8sdKhGTDfZ0nJ1TNKGyNqlVios3elS50z8DuhCs7sNRs
         UClA==
X-Gm-Message-State: ACrzQf0CSwMOPzwoE2nQuvZGOvZRPeOpuxsKw3eQmz8RIXolmUrc3YlT
	SRvtWHu3BeI6ATKUBkcMEBe+wjYQKU696osLn9qxeYKQL5RMJlqNKW0+DaWrLxV44bOrPm7XoiF
	0JIlPwvcrA+iG2sa1fWtsEn3wvX3YA/AcLFKl/IXQ76JP79bHxlC5xCVfabxvVgDxNsI=
X-Received: by 2002:a05:6a00:84b:b0:56d:3cf5:1031 with SMTP id q11-20020a056a00084b00b0056d3cf51031mr30151549pfk.75.1667561410284;
        Fri, 04 Nov 2022 04:30:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ZmqK77wd2hCvap39otYWhRGk7HSG6DR3nAEU2Jv3tyaB6tseG9Ymp8fTHcgu2gG1DjEWLsQ==
X-Received: by 2002:a05:6a00:84b:b0:56d:3cf5:1031 with SMTP id q11-20020a056a00084b00b0056d3cf51031mr30151497pfk.75.1667561409825;
        Fri, 04 Nov 2022 04:30:09 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p189-20020a625bc6000000b0056abff42a8bsm2503420pfb.69.2022.11.04.04.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:30:08 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
Date: Fri,  4 Nov 2022 19:29:55 +0800
Message-Id: <20221104113000.487098-1-coxu@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_043203_640254_D29E377E 
X-CRM114-Status: GOOD (  24.85  )
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

RFC v2
 - libcryptsetup interacts with the kernel via sysfs instead of "hacking"
   dm-crypt 
   - to save a kdump copy of the LUKS volume key in 1st kernel
   - to add a logon key using the copy for libcryptsetup in kdump kernel [Milan]
   - to avoid the incorrect usage of LUKS master key in dm-crypt [Milan]
 - save the kdump copy of LUKS volume key randomly [Jan]
 - mark the kdump copy inaccessible [Pingfan]
 - Miscellaneous
   - explain when operations related to the LUKS volume key happen [Jan]
   - s/master key/volume key/g
   - use crash_ instead of kexec_ as function prefix
   - fix commit subject prefixes e.g. "x86, kdump" to x86/crash

With kdump enabled, when the 1st kernel crashes, the system could boot
into the kdump/crash kernel and dump the memory image i.e. /proc/vmcore
to a specified target. Currently, when dumping vmcore to a LUKS
encrypted device, there are two problems,

 - for some machines, a system administrator may not have a chance to
   enter the password to decrypt the device in kdump initramfs after the
   1st kernel crashes 

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump. Take Fedora example, by default, only 256M is reserved for
   systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
   to be reserved for kdump. Note if the memory reserved for kdump can't
   be used by 1st kernel i.e. an user sees ~1300M memory missing in the
   1st kernel. 
 
Besides users (at least for Fedora) usually expect kdump to work out of
the box i.e. no manual password input is needed. And it doesn't make
sense to derivate the key again in kdump kernel which seems to be
redundant work.

Based on Milan's feedback [1] on Kairui's ideas to support kdump with
LUKS encryption, this patch set addresses the above issues by reusing
the LUKS volume key in kdump kernel and here is the life cycle of this
kdump copy of LUKS volume key,

 1. After the 1st kernel loads the initramfs during boot, systemd
    asks for a passphrase from the user and uses it to de-crypt the LUKS
    volume key

 2. After the 1st kernel saving the volume key as a logon key,
    libcrytpsetup notifies the kernel to read this logon key and store a
    temporary copy by writing the key description to
    /sys/kernel/crash_luks_volume_key

 3. After switching to the real root fs, kdump.serivce is started and it 
    loads the kdump kernel using the kexec_file_load syscall

 4. The kexec_file_load syscall saves the temporary copy of the volume
    key to kdump reserved memory and wipe the copy.

 5. When the 1st kernel crashes and kdump kernel is booted,
    libcryptsetup asks the kdump kernel to add a logon key using
    the volume key stored in kdump reserved memory by writing the key
    description to /sys/kernel/crash_luks_volume_key

 6. The system gets rebooted to the 1st kernel after dumping vmcore to
    the LUKS encrypted device is finished

Note the kdump copy of LUKS volume key never leaves the kernel space and
is saved in the memory area exclusively reserved for kdump where even
the 1st kernel has no direct access. 

Milan's major concern [2] on previous version is "storing the encryption
key to yet another place are creating another attack vector". To further
secure this copy, two additional protections are added,
 - save the copy randomly in kdump reserved memory as suggested by Jan
 - clear the _PAGE_PRESENT flag of the page that stores the copy as
   suggested by Pingfan

If there is no further security concern with this approach or any other
concern, I will drop the following assumptions,
  - only x86 is supported
  - there is only one LUKS device for the system

to extend the support to other architectures including POWER, ARM and
s390x and address the case of multiple LUKS devices. Any feedback will be 
appreciated, thanks!

For a proof of concept, I've patched cryptsetup [3] in a quick-and-dirty
way to support a new option "--kdump-kernel-master-key"
and hacked systemd [4]. It works for Fedora 35.

[1] https://yhbt.net/lore/all/e5abd089-3398-fdb4-7991-0019be434b79@gmail.com/
[2] https://lwn.net/ml/linux-kernel/c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com/
[3] https://gitlab.com/coxu/cryptsetup/-/commit/750a46d933fac82e0c994b5c41de40a0b8cac647
[4] https://github.com/coiby/systemd/tree/reuse_kdump_master_key

Coiby Xu (5):
  kexec_file: allow to place kexec_buf randomly
  crash_dump: save the LUKS volume key temporarily
  x86/crash: pass the LUKS volume key to kdump kernel
  x86/crash: make the page that stores the LUKS volume key inaccessible
  crash_dump: retrieve LUKS volume key in kdump kernel

 arch/x86/include/asm/crash.h       |   1 +
 arch/x86/kernel/crash.c            |  47 ++++++-
 arch/x86/kernel/kexec-bzimage64.c  |   7 +
 arch/x86/kernel/machine_kexec_64.c |  16 +++
 include/linux/crash_core.h         |   2 +
 include/linux/crash_dump.h         |   2 +
 include/linux/kexec.h              |   6 +
 kernel/crash_dump.c                | 200 +++++++++++++++++++++++++++++
 kernel/kexec_file.c                |  15 +++
 kernel/ksysfs.c                    |  19 +++
 10 files changed, 314 insertions(+), 1 deletion(-)

-- 
2.37.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
