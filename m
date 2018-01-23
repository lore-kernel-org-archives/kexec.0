Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eduJ6-0001Fj-2t
 for kexec@lists.infradead.org; Tue, 23 Jan 2018 08:51:53 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [makedumpfile PATCH 0/2] Fix calculations in exclude_segment()
Date: Tue, 23 Jan 2018 08:49:48 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701F37744@BPXM01GP.gisp.nec.co.jp>
References: <cover.1516354241.git.ptesarik@suse.com>
 <20180123062813.GB1968@localhost.localdomain>
In-Reply-To: <20180123062813.GB1968@localhost.localdomain>
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
To: Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.com>
Cc: Keiichirou Suzuki <kei-suzuki@xr.jp.nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On 01/19/18 at 12:45pm, Petr Tesarik wrote:
>> I have observed that makedumpfile --mem-usage shows bogus numbers
>> on a kaslr-enabled kernel. This boils down to incorrect calculations
>> in exclude_segment(). Consequently, data beyond a split LOAD segment
>> are read from the wrong file offset.
>>
>> Petr Tesarik (2):
>>   Fix off-by-one errors in exclude_segment()
>>   Fix physical-to-virtual conversion in exclude_segment()
>>
>>  elf_info.c | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>
>Ack the series, thanks!

Thanks guys, I'll merge them into v1.6.3.

Regards,
Atsushi Kumagai


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
