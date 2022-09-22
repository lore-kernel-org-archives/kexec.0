Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313A9C6FA86
	for <kexec@archiver.kernel.org>; Thu, 22 Sep 2022 10:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BfoUC6Pe0Ax/o0zUFG34whW4fndb1nK442I86ZqCJZM=; b=o9Yq3AL+1ktMrVcpj+uGTZYvE8
	tzWjHqfQAc2sSaYEdnX7euGMDKXgF5HnUscZte117PLYmhlbhZSoPmhDJTA9I073wlLAqE5j+C1+P
	3SxdtOosAC2i2LYsO1f/Fm9F6WG8F9dqlwLif16Km7fMd56ejCNWLCLBw5r1cywonhSeQ06GRCXD2
	mC6OnL4g1mLM/WAJQNFOoyM2irV4WgOA1wS47D5BDGm+MPNnS4N7ySMPrTIexpjm298ldnGJ5HpBV
	eAJ2FjOZP5mZuvf6Z+NzI+f/zyckn0BVfLROP8hjfv2VzMVGPxnpU59LnWRM73Nc1qKGLhPMwEgpJ
	yU5bTplQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obJUE-00ExHn-JA; Thu, 22 Sep 2022 10:31:18 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obJU9-00ExEG-4h
	for kexec@lists.infradead.org; Thu, 22 Sep 2022 10:31:16 +0000
Received: from [10.130.0.193] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx32tdOSxj5w0gAA--.48410S3;
	Thu, 22 Sep 2022 18:30:54 +0800 (CST)
Subject: Re: [PATCH v3 1/3] LoongArch: Add kexec support
To: Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>,
 Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>
References: <1663210426-15446-1-git-send-email-tangyouling@loongson.cn>
 <1663210426-15446-2-git-send-email-tangyouling@loongson.cn>
 <bfe4fed8b1da17561214cf9f2cf5acdf0e74d0ea.camel@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Guo Ren <guoren@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kexec@lists.infradead.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From: Youling Tang <tangyouling@loongson.cn>
Message-ID: <75a059e8-108f-93f5-5d4e-01b09224f419@loongson.cn>
Date: Thu, 22 Sep 2022 18:30:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <bfe4fed8b1da17561214cf9f2cf5acdf0e74d0ea.camel@xry111.site>
X-CM-TRANSID: AQAAf8Bx32tdOSxj5w0gAA--.48410S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtFW3JryfAF4UWw48tF48Crg_yoWDKrbE9w
	47Wrn5GF1fXrsrtan8Kr13tF98t3y0vF1YgryIv3y5A348tw48W39IywnYyF1kXrWkAanx
	Ars8ZrZYyw1I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUgHanUUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_033113_589457_D7F19FCC 
X-CRM114-Status: GOOD (  14.17  )
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

Hi, Ruoyao

On 09/22/2022 06:00 PM, Xi Ruoyao wrote:
> On Thu, 2022-09-15 at 10:53 +0800, Youling Tang wrote:
>> +int machine_kexec_prepare(struct kimage *kimage)
>> +{
>> +       int i;
>> +       void *dtb = (void *)KEXEC_BLOB_ADDR;
>> +
>> +       kexec_image_info(kimage);
>> +
>> +       /* Find the Flattened Device Tree */
>> +       for (i = 0; i < kimage->nr_segments; i++) {
>> +               if (!fdt_check_header(kimage->segment[i].buf)) {
>
> Hi Youling,
>
> When I build Huacai's tree
> (https://github.com/loongson/linux/commits/loongarch-next), there is a
> strange error linking vmlinux:
>
> ld: arch/loongarch/kernel/machine_kexec.o: in function `machine_kexec_prepare':
> /home/xry111/git-repos/linux/arch/loongarch/kernel/machine_kexec.c:70: undefined reference to `fdt_check_header'
>
> Not sure why...

This is because of the problem after efistub removes the fdt
modification, I will reimplement kexec/kdump. This build error can be
avoided by turning off CONFIG_KEXEC temporarily, tomorrow I will submit
a new kexec/kdump implementation.

Thanks,
Youling.
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
