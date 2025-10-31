Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789C3CCFA00
	for <kexec@archiver.kernel.org>; Fri, 31 Oct 2025 08:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gA7ZdMOFUrwORlyoHCw1cLLJwSTvXr7E+PswkD5pAyo=; b=I/7q/iV8SENiIhqGUDGDzv9CGz
	j7KiQF87UfMA6rUlfTwIl68/npO/p2/4xeSpxlRMzUA/fwtCpo3l8cGcMdw2dR/xZFqg6XbXydqj3
	cH2NNI0COhDFF1g1wTWPlkhswHrIYfM/PS9Hg3g/MH7E39YA7uFivsVWmHsGJtiC65cNCyfnPwHaB
	ggv7PJpF5w2cNaJVUOdaCmlwbo202mBgtlvuYu2VZ01CipqXYTcAZbFbJl6HW7wFQXwKthfJ+BEqT
	A7nus62DOrT87AyUtTdfytiXvX3jbJPuPsl7lbyvbhNjLBECLKFk8/x6RgIwEseyeU3hDfiqm8AhJ
	eIWfee2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEkpS-00000005hBR-0KE7;
	Fri, 31 Oct 2025 08:49:50 +0000
Received: from smtpbg151.qq.com ([18.169.211.239])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEkpO-00000005h8o-1bHX
	for kexec@lists.infradead.org;
	Fri, 31 Oct 2025 08:49:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761900554;
	bh=gA7ZdMOFUrwORlyoHCw1cLLJwSTvXr7E+PswkD5pAyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=hQSuJfq/E7xJCmOAXgX3QEXQI/aHSxghQITfUQK8c0Ij3/Bcpve/zedGbm/2gTMAY
	 K5xFcvkUHI6w89MCWpXmt03SSpyQVDZ52yr8+a8MjmWmVsbj4pMbsxtcKpWac+vUg4
	 iG/fTnTiOCLdI0feNd8bffszQIJqWKQk3yaZDzTI=
X-QQ-mid: esmtpsz19t1761900551ta93a4bd0
X-QQ-Originating-IP: R2zG6nYcmdELVDw2wE22vU78I3APWYCsFEEuPMuR4OU=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Oct 2025 16:49:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9559098418288472384
Message-ID: <2D19268A448AA783+4e165a7d-fdf1-48e8-a651-63d9a77dc823@uniontech.com>
Date: Fri, 31 Oct 2025 16:49:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: print out debugging message if required for
 kexec_load
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251030073316.529106-1-maqianga@uniontech.com>
 <aQMzFnqMC0MnLZFO@MiWiFi-R3L-srv>
 <C798DAB0066FD66B+590e2398-b667-40dd-abfb-99dcd728b573@uniontech.com>
 <aQNvHdZcVzletjdi@MiWiFi-R3L-srv>
 <9362A6495165FCC0+d659800e-6751-4d26-a8b8-183705798e96@uniontech.com>
 <aQRv1JCoeYY4u7OX@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aQRv1JCoeYY4u7OX@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NkLA2q2LD229Gp9FXUJXSXupBecfS9rlTzgIInxy/g2WKvt/h0WCE8+E
	KgBVZVUZYA/ezIQTY24XqxP5At+ejZQqWaU88ZaArKlx4gb1ctlviJYAC876lgGqm/7rznF
	87zKmCa+kjxXxS5WUCQNbuEMEz0LzBEBrTNosLEaLsPDu5IpwUaWNdoTUzSslU7TIo4i6B9
	9edEWJOLQLLoJv1o1Gw5i9IYReH3TDeR2iZgF9tXtgzw5o/6NMpdviT4fcOfHEeW4vPLbH6
	BGzfHjNy0ccKGaxosqr1MjYuGri3ifwnIgBVWMhCX/I05ZoCZp4cRwK/yjeGVrfXj0+Mlwl
	Jgl0cosouc4ECCp4Cq5Ps/NNvyrB5v9x5/YvwI5neda+eCwSMYUfrHE35Hlv8aOqmxN547R
	V3spI5WknAN5VOeawGrVWvmcgRuKtIzLXYh6HPOWDvfU4gMvQUozEh7w6PP2iwJtIkART66
	RyINkQL05BvL4i7EtFPu7lJIJKsvVFSX1X5CIfAkyHFQizHbhXEVoqslboGa9nfzBDVwyMi
	9znMU3TvuP1b+enZxQCta9kaWXjtvNIdyYfprg6qPHmiHp1x+NzDq4H/zzAEPB5oTJRJ53e
	wgxCkd1cFk44ZZxtxD8cHGl5sIBLe2G/eH7j9QwEvz1cqXcoedRH2cO7QvCarfZ5nFSt3mA
	ljEHUR9OXIku1NR3O+VK6lRD/GmyLbaXPVumYfwfx+MLIM/RfagKZaR0LvDp0Vhw2a9sAOu
	+FMnfwU/MIcWH1B9ZKyKz0D8Ml8xc0fy1jJrZETs6DDPw+8AxGBpjewwOZ3nr73eRCa/CsZ
	/mIvUKT9szRKFjjUj6AwI9nGDojMUcRYHFHU1cVGtf1ny48VimG6YI9lH7RFM+8nMVVcI7n
	Xs9WT6UZrNainrVM5cFuGXvaflkcC5SrO3Czj/yI4662U8y9xwPa+5blHxUKBtulSqF5BV0
	BZdT971QxvpobykcZxvqoeVMxuWDWD0bavKX22/KuA9BVURp6VchwscW+CDmX7x3/hBMOns
	BSGl43em2hQd+V6uSb
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_014946_952115_0626E6FD 
X-CRM114-Status: GOOD (  24.54  )
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


在 2025/10/31 16:14, Baoquan He 写道:
> On 10/31/25 at 10:40am, Qiang Ma wrote:
>> 在 2025/10/30 21:58, Baoquan He 写道:
>>> On 10/30/25 at 07:41pm, Qiang Ma wrote:
>>>> 在 2025/10/30 17:42, Baoquan He 写道:
>>>>> On 10/30/25 at 03:33pm, Qiang Ma wrote:
>>>>>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>>>>>> if required") has added general code printing in kexec_file_load(),
>>>>>> but not in kexec_load().
>>>>>>
>>>>>> Especially in the RISC-V architecture, kexec_image_info() has been
>>>>>> removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
>>>>>> message if required")). As a result, when using '-d' for the kexec_load
>>>>>> interface, print nothing in the kernel space. This might be helpful for
>>>>>> verifying the accuracy of the data passed to the kernel. Therefore, refer to
>>>>>> this commit a85ee18c7900 ("kexec_file: print out debugging message
>>>>>> if required"), debug print information has been added.
>>>>> kexec_file_dbg_print setting when CONFIG_KEXEC_FILE is set. I doubt it
>>>>> doesn't work when you unset CONFIG_KEXEC_FILE.
>>>> Yes, I just actually tested it and it really doesn't work when unset
>>>> CONFIG_KEXEC_FILE.
>>>>
>>>> In the next version, I can add a KEXEC_DEBUG for the kernel and kexec-tools.
>>> Hold on please, it may not need that highweight change. I will reply to
>>> you tomorrow if I have other idea.
>> Ok. My current idea is to refer to kexec_file, define a kexec_dbg_print,
>> initialize it in the kimage_alloc_init(), modify KEXEC_FLAGS and
>> kexec_dprintk,
>> and add the judgment of kexec_debug.
> Maybe we can unify it because kexec_file_dbg_print is declared and
> defined in CONFIG_KEXEC_CORE scope. Rename it to kexec_core_dbg_print
> and initialize it in do_kimage_alloc_init() for both, or in
> kimage_alloc_init() for kexec, and kimage_file_alloc_init() for
> kexec_file. It needs a new flag for kexec. What do you think?
I think it's okay.

I had also considered unifying a flag before, but I thought there was a 
possibility that
kexec_load and kexec_file_load could be executed simultaneously, so I 
gave up.
Later, after looking at the kexec-tools code, I found that 
kexec_file_load would be executed first.
So, it would be better to unify them into one flag.
>
> Please feel free to take it as reference, or you can go in other ways
> you have better one.
OK.
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ff7e231b0485..df33a0dd5780 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -525,10 +525,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>   static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>   #endif
>   
> -extern bool kexec_file_dbg_print;
> +extern bool kexec_core_dbg_print;
>   
>   #define kexec_dprintk(fmt, arg...) \
> -        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
> +        do { if (kexec_core_dbg_print) pr_info(fmt, ##arg); } while (0)
>   
>   extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
>   extern void kimage_unmap_segment(void *buffer);
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 28008e3d462e..570adb845662 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -42,6 +42,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
>   	if (!image)
>   		return -ENOMEM;
>   
> +	kexec_core_dbg_print = !!(flags & KEXEC_DEBUG);
>   	image->start = entry;
>   	image->nr_segments = nr_segments;
>   	memcpy(image->segment, segments, nr_segments * sizeof(*segments));
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index fa00b239c5d9..3af3ba77a3bd 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -619,6 +619,7 @@ void kimage_free(struct kimage *image)
>   	if (image->file_mode)
>   		kimage_file_post_load_cleanup(image);
>   
> +	kexec_core_dbg_print = false;
>   	kfree(image);
>   }
>   
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index eb62a9794242..4a24aadbad02 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -138,8 +138,6 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>   	 */
>   	kfree(image->image_loader_data);
>   	image->image_loader_data = NULL;
> -
> -	kexec_file_dbg_print = false;
>   }
>   
>   #ifdef CONFIG_KEXEC_SIG
> @@ -314,7 +312,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
>   	if (!image)
>   		return -ENOMEM;
>   
> -	kexec_file_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
> +	kexec_core_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
>   	image->file_mode = 1;
>   
>   #ifdef CONFIG_CRASH_DUMP
>
>

