Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53191C0015E
	for <kexec@archiver.kernel.org>; Wed, 26 Jul 2023 18:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PRNNwVVmirXlyElj996FuKQKYp+uYyIQJRZo0SlaQ5Q=; b=zpUjFsi3t5YCpA
	q7cWdEQHURjV02uyoeNcSWp/F5lt4+glLNB/kp/On/u+do7Yw9MBnjKNBHl7Bvr9YmNyhi+UmDd5p
	rYlWc8FX3eJSiJljq8cKcUlv+JaJd2ZKZ3PO2UQcXqUCLU3Rm+861DGkTyu8EKvu/L7EG1dsqAd34
	McivnppRwxt2jMuDhqV+GwuoOvWPU9blrK0LWTkVxzB8iiYCMaQwIHn9tXHEY+rHdjMCk/Yixq3Zk
	cfX4OPKXqi2cV9hV3/ZjsIpGQNib+iEcS3k0Y+emLDHC1r+PCJnA5G3qGQ4tSiXxYO3cP4ID7bg8l
	iPYsQxw9tudtNtRrW/Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOjFD-00BHAk-0v;
	Wed, 26 Jul 2023 18:28:19 +0000
Received: from [14.137.139.154] (helo=frasgout12.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOjF9-00BH9C-1k;
	Wed, 26 Jul 2023 18:28:17 +0000
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RB29j6nK3z9xFqw;
	Thu, 27 Jul 2023 02:14:49 +0800 (CST)
Received: from [10.81.211.226] (unknown [10.81.211.226])
	by APP2 (Coremail) with SMTP id GxC2BwB3IjmaZcFkGUkMBQ--.1285S2;
	Wed, 26 Jul 2023 19:27:50 +0100 (CET)
Message-ID: <a6a112d4-8fe7-4f73-b7c9-8eaf5e9d7ba1@huaweicloud.com>
Date: Wed, 26 Jul 2023 20:27:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/3] riscv/kexec: load initrd high in available memory
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor.dooley@microchip.com>, Li Huafei <lihuafei1@huawei.com>,
 Liao Chang <liaochang1@huawei.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Kees Cook <keescook@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>, Heiko Stuebner <heiko@sntech.de>,
 Ricardo Ribalda <ribalda@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 Li Zhengyu <lizhengyu3@huawei.com>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
 kexec@lists.infradead.org, open list <linux-kernel@vger.kernel.org>,
 Torsten Duwe <duwe@suse.de>, Roberto Sassu <roberto.sassu@huaweicloud.com>,
 petr@tesarici.cz
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
 <67c8eb9eea25717c2c8208d9bfbfaa39e6e2a1c6.1690365011.git.petr.tesarik.ext@huawei.com>
 <20230726-busily-marsupial-504e9ff2d873@spud>
From: Petr Tesarik <petrtesarik@huaweicloud.com>
In-Reply-To: <20230726-busily-marsupial-504e9ff2d873@spud>
X-CM-TRANSID: GxC2BwB3IjmaZcFkGUkMBQ--.1285S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ury8WrWUJFy3JF4UtF4kCrg_yoW8WF1fpr
	4fGw17GFWDA3y5ZrWUta17u347Zws3Jw1jgF1UKFy8Zr1Y9FWjkryUGrWxWrykAryvg3W8
	JFy5Zr12v3WUJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_112815_853221_FC1E1237 
X-CRM114-Status: GOOD (  12.65  )
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

On 7/26/2023 6:38 PM, Conor Dooley wrote:
> On Wed, Jul 26, 2023 at 11:54:01AM +0200, Petr Tesarik wrote:
>> From: Torsten Duwe <duwe@suse.de>
>>
>> When initrd is loaded low, the secondary kernel fails like this:
>>
>>  INITRD: 0xdc581000+0x00eef000 overlaps in-use memory region
>>
>> This initrd load address corresponds to the _end symbol, but the
>> reservation is aligned on PMD_SIZE, as explained by a comment in
>> setup_bootmem().
>>
>> It is technically possible to align the initrd load address accordingly,
>> leaving a hole between the end of kernel and the initrd, but it is much
>> simpler to allocate the initrd top-down.
>>
>> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
>> Signed-off-by: Torsten Duwe <duwe@suse.de>
>> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
>> Cc: stable@vger.kernel.org
> 
> Trying to align it might be worthwhile, but the simple fix makes sense
> for now & w.r.t backporting.

On a second thought, allocating the initrd at the top of the range is
probably even better, because the kernel can unpack to low addresses,
resulting in less fragmented memory. See diagrams.

Top-down initrd:

+----------+          +----------+
|  initrd  |          |          |
+----------+          |   free   |
|          |          |          |
|          |  unpack  +----------+
|   free   |  ----->  | unpacked |
|          |          |  initrd  |
+----------+          +----------+
|  kernel  |          |  kernel  |
+----------+          +----------+


Aligned initrd:

+----------+          +----------+
|          |          |   free   |
|          |          +----------|
|   free   |          | unpacked |
|          |          |  initrd  |
+----------+  unpack  +----------+
|  initrd  |  ----->  |   free   |
+----------+          +----------+
|  kernel  |          |  kernel  |
+----------+          +----------+

Petr T


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
