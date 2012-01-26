Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pz0-f49.google.com ([209.85.210.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RqMys-0003uT-WB
 for kexec@lists.infradead.org; Thu, 26 Jan 2012 10:55:03 +0000
Received: by dadv40 with SMTP id v40so452036dad.36
 for <kexec@lists.infradead.org>; Thu, 26 Jan 2012 02:55:00 -0800 (PST)
Message-ID: <4F2130FF.6030406@gmail.com>
Date: Thu, 26 Jan 2012 18:54:55 +0800
From: Cong Wang <xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Subject: Re: Makedumpfile 1.4.2 release
References: <4F1FDE5F.5080403@gmail.com> <4F1FDF52.8050301@gmail.com>
 <20120126144343.4b4969a3.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120126144343.4b4969a3.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

On 01/26/2012 01:43 PM, Atsushi Kumagai wrote:
> Hi Cong,
>
>> By the way, the latest kernel supported by makedumpfile 1.4.2 is still
>> 2.6.36.
>>
>> makedumpfile.h
>> 383:#define LATEST_VERSION		KERNEL_VERSION(2, 6, 36)/* linux-2.6.36 */
>>
>> The latest stable kernel is already 3.2.1. :) So, what prevents
>> makedumpfile supporting newer kernels?
>
> Sorry for inconvenience.
> We have postponed supporting newer kernels because we were busy
> at other developments.
>
> Now we will support newer kernels step by step.
> Please give us a little more time.

Yeah, sure, I was just wondering if anything I can help. ;)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
