Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D727AC05027
	for <kexec@archiver.kernel.org>; Wed,  1 Feb 2023 08:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XtMzyS2mY3O8EizzLXd2ql9Q7oW2QINYQU1xa5itNg8=; b=D6azUns4SIBou9
	SJ6Kj+PX6BGEYBqqCaGmkma6vRq4I2OmeXeUzn0RmTSjeiiHkRfM93t2V+/qy0odvLZLkdUHS6cQy
	hLreaSd07YVgULmXa51YW7GQblOT72vme5GXDwf/QwBDwPuAkD0L/0dKeiWZ2nd6Gug98/uk40Rkb
	xE5CdhAM5IGECFVfftCptbDWKu8I7TEXW8+DuRDKJ6BBifXgdiTwdaLwsCwioht+vULiBF54Zld3Q
	MwDKLMfVEOFhQTBYREmuQ28Ue36QKPYCB6UdAomTlzFtxNUAw+6VfjKt1VcEd4pEYAg5bWm2Kl+N1
	f+340OLd8k8wwmFUW3pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN8K4-00AlpC-EG; Wed, 01 Feb 2023 08:18:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN8K0-00AloU-PG
	for kexec@lists.infradead.org; Wed, 01 Feb 2023 08:18:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675239503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgQuCO8xB/43JdXjOiR6k2nwVgC6qNNzFrln4BazGqw=;
	b=dxoooRcoedSVNDF0G2YTL3T+InxjHDR9ekDyayKeeWnVKXCGpLGDtz8YzpVKRqCpMvDB4Z
	oy7lVNR0zRu7IMeOecNN2tUOaFjWZwIi2skUr5daikfuQhiT5JuPNEtqg8wgSqM5S5MBNM
	CX/xhUF4TMa/zPR1mnyJm24LrUj8MuQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-Di-7GZaYMX-GJGyl-HdKkw-1; Wed, 01 Feb 2023 03:18:20 -0500
X-MC-Unique: Di-7GZaYMX-GJGyl-HdKkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9ABD8185A794;
	Wed,  1 Feb 2023 08:18:19 +0000 (UTC)
Received: from localhost (ovpn-13-89.pek2.redhat.com [10.72.13.89])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C501D112132C;
	Wed,  1 Feb 2023 08:18:18 +0000 (UTC)
Date: Wed, 1 Feb 2023 16:18:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>, Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com, Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
Message-ID: <Y9ogR0/zPRBGI1kq@MiWiFi-R3L-srv>
References: <20221104113000.487098-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221104113000.487098-1-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_001824_919414_4C1FD309 
X-CRM114-Status: GOOD (  45.94  )
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

Hi Coiby,

On 11/04/22 at 07:29pm, Coiby Xu wrote:
> RFC v2
>  - libcryptsetup interacts with the kernel via sysfs instead of "hacking"
>    dm-crypt 
>    - to save a kdump copy of the LUKS volume key in 1st kernel
>    - to add a logon key using the copy for libcryptsetup in kdump kernel [Milan]
>    - to avoid the incorrect usage of LUKS master key in dm-crypt [Milan]
>  - save the kdump copy of LUKS volume key randomly [Jan]
>  - mark the kdump copy inaccessible [Pingfan]
>  - Miscellaneous
>    - explain when operations related to the LUKS volume key happen [Jan]
>    - s/master key/volume key/g
>    - use crash_ instead of kexec_ as function prefix
>    - fix commit subject prefixes e.g. "x86, kdump" to x86/crash
> 
> With kdump enabled, when the 1st kernel crashes, the system could boot
> into the kdump/crash kernel and dump the memory image i.e. /proc/vmcore
> to a specified target. Currently, when dumping vmcore to a LUKS
> encrypted device, there are two problems,

I went through this patchset, have some concerns. Do you mind sending a
formal patchset with some adjustment?

1) maybe put the luks key handling related to crash_dump out into
a separate file. e.g kernel/crash_dump_luks.c. This will reduce the code
complexity to other kdump code from luks handling. At least from code
reading side.
2) please rearrange your patches order so that generic luks handling at
the beginning. Then the x86 specific code comes next. Please refer to
below patchset. Like this, other arch can easily add its specific code
accordingly.

[PATCH v18 0/7] crash: Kernel handling of CPU and memory hot un/plug

And I am wondering
1) in what proportion the luks system is used,
2) in which cases the dumped vmcore have to be saved into luks disk,
   no workaround?
3) with the 1 hour aging of luks key, to what extent it's still
   worthwhile to add the support of luks kdumping? E.g for me, I have
   been using Fedora, and often start kexec-tools service when I need to
   do test kdump w/o reboot. With that, the key has aged.

I am not familiar with LUKS and it's key mechanism, my above concerns
could be shallow, anyone please help clarify if it does impact. Please
also show your support if this adding is really helpful.

Thanks
Baoquan

> 
>  - for some machines, a system administrator may not have a chance to
>    enter the password to decrypt the device in kdump initramfs after the
>    1st kernel crashes 
> 
>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>    which is quite memory-consuming compared to the limited memory reserved
>    for kdump. Take Fedora example, by default, only 256M is reserved for
>    systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
>    to be reserved for kdump. Note if the memory reserved for kdump can't
>    be used by 1st kernel i.e. an user sees ~1300M memory missing in the
>    1st kernel. 
>  
> Besides users (at least for Fedora) usually expect kdump to work out of
> the box i.e. no manual password input is needed. And it doesn't make
> sense to derivate the key again in kdump kernel which seems to be
> redundant work.
> 
> Based on Milan's feedback [1] on Kairui's ideas to support kdump with
> LUKS encryption, this patch set addresses the above issues by reusing
> the LUKS volume key in kdump kernel and here is the life cycle of this
> kdump copy of LUKS volume key,
> 
>  1. After the 1st kernel loads the initramfs during boot, systemd
>     asks for a passphrase from the user and uses it to de-crypt the LUKS
>     volume key
> 
>  2. After the 1st kernel saving the volume key as a logon key,
>     libcrytpsetup notifies the kernel to read this logon key and store a
>     temporary copy by writing the key description to
>     /sys/kernel/crash_luks_volume_key
> 
>  3. After switching to the real root fs, kdump.serivce is started and it 
>     loads the kdump kernel using the kexec_file_load syscall
> 
>  4. The kexec_file_load syscall saves the temporary copy of the volume
>     key to kdump reserved memory and wipe the copy.
> 
>  5. When the 1st kernel crashes and kdump kernel is booted,
>     libcryptsetup asks the kdump kernel to add a logon key using
>     the volume key stored in kdump reserved memory by writing the key
>     description to /sys/kernel/crash_luks_volume_key
> 
>  6. The system gets rebooted to the 1st kernel after dumping vmcore to
>     the LUKS encrypted device is finished
> 
> Note the kdump copy of LUKS volume key never leaves the kernel space and
> is saved in the memory area exclusively reserved for kdump where even
> the 1st kernel has no direct access. 
> 
> Milan's major concern [2] on previous version is "storing the encryption
> key to yet another place are creating another attack vector". To further
> secure this copy, two additional protections are added,
>  - save the copy randomly in kdump reserved memory as suggested by Jan
>  - clear the _PAGE_PRESENT flag of the page that stores the copy as
>    suggested by Pingfan
> 
> If there is no further security concern with this approach or any other
> concern, I will drop the following assumptions,
>   - only x86 is supported
>   - there is only one LUKS device for the system
> 
> to extend the support to other architectures including POWER, ARM and
> s390x and address the case of multiple LUKS devices. Any feedback will be 
> appreciated, thanks!
> 
> For a proof of concept, I've patched cryptsetup [3] in a quick-and-dirty
> way to support a new option "--kdump-kernel-master-key"
> and hacked systemd [4]. It works for Fedora 35.
> 
> [1] https://yhbt.net/lore/all/e5abd089-3398-fdb4-7991-0019be434b79@gmail.com/
> [2] https://lwn.net/ml/linux-kernel/c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com/
> [3] https://gitlab.com/coxu/cryptsetup/-/commit/750a46d933fac82e0c994b5c41de40a0b8cac647
> [4] https://github.com/coiby/systemd/tree/reuse_kdump_master_key
> 
> Coiby Xu (5):
>   kexec_file: allow to place kexec_buf randomly
>   crash_dump: save the LUKS volume key temporarily
>   x86/crash: pass the LUKS volume key to kdump kernel
>   x86/crash: make the page that stores the LUKS volume key inaccessible
>   crash_dump: retrieve LUKS volume key in kdump kernel
> 
>  arch/x86/include/asm/crash.h       |   1 +
>  arch/x86/kernel/crash.c            |  47 ++++++-
>  arch/x86/kernel/kexec-bzimage64.c  |   7 +
>  arch/x86/kernel/machine_kexec_64.c |  16 +++
>  include/linux/crash_core.h         |   2 +
>  include/linux/crash_dump.h         |   2 +
>  include/linux/kexec.h              |   6 +
>  kernel/crash_dump.c                | 200 +++++++++++++++++++++++++++++
>  kernel/kexec_file.c                |  15 +++
>  kernel/ksysfs.c                    |  19 +++
>  10 files changed, 314 insertions(+), 1 deletion(-)
> 
> -- 
> 2.37.3
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
