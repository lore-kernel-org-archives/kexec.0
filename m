Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c160D-0007M3-Dm
 for kexec@lists.infradead.org; Mon, 31 Oct 2016 06:23:26 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] Fix module module_init/init_size offsets for v4.5 kernel
Date: Mon, 31 Oct 2016 06:17:00 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E7B73C@BPXM01GP.gisp.nec.co.jp>
References: <1477631234-15500-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <14d7f3de-37f1-786c-e7e3-96d7f9c89bed@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E7B213@BPXM01GP.gisp.nec.co.jp>
 <d2442381-6e06-fba1-750d-560978df5a4f@linux.vnet.ibm.com>
In-Reply-To: <d2442381-6e06-fba1-750d-560978df5a4f@linux.vnet.ibm.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Pratyush Anand <panand@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On Friday 28 October 2016 12:06 PM, Atsushi Kumagai wrote:
>>> >On Friday 28 October 2016 10:37 AM, Kamalesh Babulal wrote:
>>>> >>Kernel commit 7523e4dc50 (module: use a structure to encapsulate layout.)
>>>> >>encapsulates core_layout and init_layout into module_layout structure.
>>>> >>
>>>> >>commit fa6a75a93 (Fix module core base and size offset for kernel v4.5)
>>>> >>fixes offset value calculation for core layout's base and size, whereas
>>>> >>Kernel v4.5 module changes also needs fixing of module init_size and
>>>> >>module_init for the makedumpfile to read the correct module address.
>>>> >>
>>>> >>This patch fixes calculation of offsets values for module init_size and
>>>> >>module_init.
>>>> >>
>>>> >>Signed-off-by: Kamalesh Babulal<kamalesh@linux.vnet.ibm.com>
>>>> >>Cc: Pratyush Anand<panand@redhat.com>
>>> >
>>> >Reviewed-by: Pratyush Anand<panand@redhat.com>
>> Thanks, but I think Guenther posted the same fix which you can see
>> in the devel branch:
>>
>> commit 32dd46803944959f78e01e7c4847c465efca99a6
>> Author: Guenther Hutzl<hutzl@linux.vnet.ibm.com>
>> Date:   Wed Jul 6 20:00:54 2016 +0900
>>
>>      [PATCH] Fix module init base and size offset for kernel v4.5
>
>Thank you for pointing out the commit. Should I rebase future patch
>against devel branch.

Yes, I recommend that. It's better also for me to review.

Thanks,
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
