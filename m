Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BC1E77170
	for <kexec@archiver.kernel.org>; Wed,  4 Dec 2024 12:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MB2MAmGSlUi5YLf0fUp0VNgn+MFysC4aDDm3o00zI78=; b=QKkgnrITc9ILyWNPv5pGZ6ODQe
	4D78AQZIJ8vtLcExq+ftOP1betwEBB0sQg4lGXEpmu62FbFPoZbptDGBvxS9XZiLGF6RW6/BS0f19
	0GmRlC50z68BkTXB9hb5cPcrJz393i9XPNpk26p0GPM5EUrjmqHLBbTVVvK6ZgnZwdSTxylhhrGC2
	AmiGToCV2u+B9UDgLPO9gHDirUL78LoAxfi7+z9EBvMBm7GDwtjfplcU9d4SWkTdwfEIW5nFldU65
	pRMX8ReVsWomee6Uea2btcaS7bCpK6/ViKCP4jNJr1rEBYXYZiAEaAnT2xC6ZqQZMGz2MeQjvdU4p
	fzcL86bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIoxc-0000000CbMW-3zod;
	Wed, 04 Dec 2024 12:58:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIou5-0000000Ca3A-1ym9
	for kexec@lists.infradead.org;
	Wed, 04 Dec 2024 12:54:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MB2MAmGSlUi5YLf0fUp0VNgn+MFysC4aDDm3o00zI78=;
	b=dQo4ssTxIMyeopv1YcD3KVbQGNNDW3P4KZYdCNxbig923f15xWFwztyquizyZ94zgoSqIa
	3S+SdmXIZpkbLPOHz27GUV8fnaK36y+NfMpPtyQuHZHl0A6JpD90TzuCx4uQt9L7owuZhY
	lT68kMjUzHBw4OpyoQo7wQjLBePg3Z8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-fzbN3uvlMRint8ySYq5Z7A-1; Wed, 04 Dec 2024 07:54:49 -0500
X-MC-Unique: fzbN3uvlMRint8ySYq5Z7A-1
X-Mimecast-MFC-AGG-ID: fzbN3uvlMRint8ySYq5Z7A
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43498af79a6so4979305e9.0
        for <kexec@lists.infradead.org>; Wed, 04 Dec 2024 04:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316888; x=1733921688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MB2MAmGSlUi5YLf0fUp0VNgn+MFysC4aDDm3o00zI78=;
        b=tjdKlHmhZVihQ/PLMiaFDh9rbLKWDHioA8FG0KN1BR3Q7RJPfVPEeBg9rkY48s6L7M
         ShUphMWtKkq432SlgNNwlzLi7uElND01RAakF8owNffKPixF2THkBx4/E5NBmdLI/ZU3
         CIlIRXAWUmlNLKQ9EYye9ZViWSj3BFD1iHwTru5YzxoUkqYT+rOYYUzbfx9KSt3v+2tA
         PGCwCt0OEh397Wrkq3OnslTXJ0btK0VNxOCBnTF6Z98kcrFzRztKDdUU3y4/gdww8ITQ
         JlEZVQa/ArQz6XhXBlQXD0k2HtXWtTcK6EwQCsKcvwCxAINg59Fv+H55nbOoZZxAEXyM
         7CWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+kfnO6esxv9rFLhB26rtURKLF6MPsZqTiJ0QCmhcjNRFoUZioi/xljDXEqodcFDmxqqIWSw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5IEs1vUed7gOPX8vkTF14bc2y2ekxFa3S0KNdS1tbxL8sQXKf
	Jg3p6C56qOmKKH9HUdwT7C5seELJphc4Uc++v6PbvTbyOZqzqG1dcVzliKQtnEbnA51LrUpOFAA
	gAQHDbZprOkywPXnP6cWacAvtOY3TONFJpboTNcevLSKHCpAQNZnK55/pJg==
X-Gm-Gg: ASbGnctvqU4JjHG1nrmzxMhRc/ROK25K1OBaEgebsbnS/ZqiVsjfKTLTlDFRkGVxM7p
	wDFEty2rs5+eIRwQ4+u5fmeRXZjIanORhbYTIe2M+DN5IEBg7Ee14YLFKpuUiuT6lSYaXulXjrm
	TWLcOk9+pEampGfX2FLTOomIUNPHmzJvX+YLenrFZubKVlZ5JdJcmxx0I2Zbwdagh29uFqelmUC
	qyu9f3O5owDdqXnh4TYKq00bMT0Lb23S1o1Bxc+TsgeHAuP2Hn3zNc2dOOhsOAJ9ikOK1NHUTHu
	uEIlWb0uI9EMK3xskC7OYJI9TSoU3xXhTZQ=
X-Received: by 2002:a05:600c:6c8a:b0:434:8e8a:d4ec with SMTP id 5b1f17b1804b1-434afc3b6e1mr245982075e9.13.1733316888157;
        Wed, 04 Dec 2024 04:54:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjMr0hScnPOMMpphAyax2V0MFBHZqym1YHIjea01hMzMXczx6opOHdnARaXNIvDZGqHVvbtg==
X-Received: by 2002:a05:600c:6c8a:b0:434:8e8a:d4ec with SMTP id 5b1f17b1804b1-434afc3b6e1mr245981785e9.13.1733316887744;
        Wed, 04 Dec 2024 04:54:47 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52c0bc7sm23514855e9.35.2024.12.04.04.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:54:46 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 00/12] fs/proc/vmcore: kdump support for virtio-mem on s390
Date: Wed,  4 Dec 2024 13:54:31 +0100
Message-ID: <20241204125444.1734652-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: plVWvPb-Sm4uFWQaIZveLgPjzThq0C6acCQCfCNTi8Q_1733316888
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_045453_588262_A1D47A24 
X-CRM114-Status: GOOD (  21.94  )
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

The only "different than everything else" thing about virtio-mem on s390
is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
kdump kernel must detect memory ranges of the crashed kernel to
include via PT_LOAD in the vmcore.

On other architectures, all RAM regions (boot + hotplugged) can easily be
observed on the old (to crash) kernel (e.g., using /proc/iomem) to create
the elfcore hdr.

On s390, information about "ordinary" memory (heh, "storage") can be
obtained by querying the hypervisor/ultravisor via SCLP/diag260, and
that information is stored early during boot in the "physmem" memblock
data structure.

But virtio-mem memory is always detected by as device driver, which is
usually build as a module. So in the crash kernel, this memory can only be
properly detected once the virtio-mem driver started up.

The virtio-mem driver already supports the "kdump mode", where it won't
hotplug any memory but instead queries the device to implement the
pfn_is_ram() callback, to avoid reading unplugged memory holes when reading
the vmcore.

With this series, if the virtio-mem driver is included in the kdump
initrd -- which dracut already takes care of under Fedora/RHEL -- it will
now detect the device RAM ranges on s390 once it probes the devices, to add
them to the vmcore using the same callback mechanism we already have for
pfn_is_ram().

To add these device RAM ranges to the vmcore ("patch the vmcore"), we will
add new PT_LOAD entries that describe these memory ranges, and update
all offsets vmcore size so it is all consistent.

My testing when creating+analyzing crash dumps with hotplugged virtio-mem
memory (incl. holes) did not reveal any surprises.

Patch #1 -- #7 are vmcore preparations and cleanups
Patch #8 adds the infrastructure for drivers to report device RAM
Patch #9 + #10 are virtio-mem preparations
Patch #11 implements virtio-mem support to report device RAM
Patch #12 activates it for s390, implementing a new function to fill
          PT_LOAD entry for device RAM

v1 -> v2:
* "fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex"
 -> Extend patch description
* "fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex"
 -> Extend patch description
* "fs/proc/vmcore: disallow vmcore modifications while the vmcore is open"
 -> Disallow modifications only if it is currently open, but warn if it
    was already open and got closed again.
 -> Track vmcore_open vs. vmcore_opened
 -> Extend patch description
* "fs/proc/vmcore: prefix all pr_* with "vmcore:""
 -> Added
* "fs/proc/vmcore: move vmcore definitions out if kcore.h"
 -> Call it "vmcore_range"
 -> Place vmcoredd_node into vmcore.c
 -> Adjust patch subject + description
* "fs/proc/vmcore: factor out allocating a vmcore range and adding it to a
   list"
 -> Adjust to "vmcore_range"
* "fs/proc/vmcore: factor out freeing a list of vmcore ranges"
 -> Adjust to "vmcore_range"
* "fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM
   ranges in 2nd kernel"
 -> Drop PROVIDE_PROC_VMCORE_DEVICE_RAM for now
 -> Simplify Kconfig a bit
 -> Drop "Kdump:" from warnings/errors
 -> Perform Elf64 check first
 -> Add regions also if the vmcore was opened, but got closed again. But
    warn in any case, because it is unexpected.
 -> Adjust patch description
* "virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM"
 -> "depends on VIRTIO_MEM" for PROC_VMCORE_DEVICE_RAM


Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

David Hildenbrand (12):
  fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex
  fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex
  fs/proc/vmcore: disallow vmcore modifications while the vmcore is open
  fs/proc/vmcore: prefix all pr_* with "vmcore:"
  fs/proc/vmcore: move vmcore definitions out of kcore.h
  fs/proc/vmcore: factor out allocating a vmcore range and adding it to
    a list
  fs/proc/vmcore: factor out freeing a list of vmcore ranges
  fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM
    ranges in 2nd kernel
  virtio-mem: mark device ready before registering callbacks in kdump
    mode
  virtio-mem: remember usable region size
  virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM
  s390/kdump: virtio-mem kdump support (CONFIG_PROC_VMCORE_DEVICE_RAM)

 arch/s390/Kconfig             |   1 +
 arch/s390/kernel/crash_dump.c |  39 ++++-
 drivers/virtio/virtio_mem.c   | 103 ++++++++++++-
 fs/proc/Kconfig               |  19 +++
 fs/proc/vmcore.c              | 283 ++++++++++++++++++++++++++--------
 include/linux/crash_dump.h    |  41 +++++
 include/linux/kcore.h         |  13 --
 7 files changed, 407 insertions(+), 92 deletions(-)


base-commit: feffde684ac29a3b7aec82d2df850fbdbdee55e4
-- 
2.47.1


