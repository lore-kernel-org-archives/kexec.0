Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dSnxD-0001mx-A5
 for kexec@lists.infradead.org; Wed, 05 Jul 2017 17:19:08 +0000
Received: by mail-wm0-x242.google.com with SMTP id p204so33955140wmg.1
 for <kexec@lists.infradead.org>; Wed, 05 Jul 2017 10:18:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170628051902.GA1719@dhcp-128-65.nay.redhat.com>
References: <1497910994-15129-1-git-send-email-xiyou.wangcong@gmail.com>
 <20170628051902.GA1719@dhcp-128-65.nay.redhat.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 5 Jul 2017 10:18:25 -0700
Message-ID: <CAM_iQpX+aZX0UcNUHhMjjU8Ne9Mv50fPOLBAUuF91khpGAnaqg@mail.gmail.com>
Subject: Re: [PATCH] vmcore-dmesg: avoid allocating large memory chunk for log
 buf
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
To: Dave Young <dyoung@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, Jun 27, 2017 at 10:19 PM, Dave Young <dyoung@redhat.com> wrote:
> On 06/19/17 at 03:23pm, Cong Wang wrote:
>> -
>> -             /* Move to next record */
>> -             current_idx = log_next(buf, current_idx);
>> +             free(msg);
>> +             /* length == 0 indicates the end of the buffer; wrap */
>
> Since the code is restructured, above line can be dropped, other wise:

Yeah, I will improve that comment and send v2.

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
