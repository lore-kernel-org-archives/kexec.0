Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrN6P-0007hB-M5
 for kexec@lists.infradead.org; Wed, 28 Oct 2015 09:33:06 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: makedumpfile-1.5.9: Introduce parallel compression processing.
Date: Wed, 28 Oct 2015 09:07:32 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DF7F43@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9701DF7CC4@BPXM01GP.gisp.nec.co.jp>
 <56308618.3080908@canonical.com>
In-Reply-To: <56308618.3080908@canonical.com>
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
To: Louis Bouchard <louis.bouchard@canonical.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Louis,

>> o Support new kernels
>>  - The supported kernel is updated to 4.1 in this version.
>>    At first I'm going to extend the supported version to 4.2, but
>>    I found an issue that makedumpfile seems to exclude necessary pages
>>    by mistake on linux 4.2. When crash-7.1.3 reads that filtered dump file,
>>    the following message is shown.
>>
>>       crash: page excluded: kernel virtual address: f3fe0000  type: "fill_task_struct"
>>
>>    This will be fixed in the next version.
>
>Have you fixed the 4.2 kernel issue already or you intend to work on it in the
>future ?

I haven't done anything yet, I was going to work from now.

>Both Debian and Ubuntu run 4.2 kernel so if waiting for a fix is acceptable I
>would rather bring in a 1.5.9 + patch version.

So it will be helpful if you can do it.


Thanks,
Atsushi Kumagai
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
