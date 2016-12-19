Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cIsIS-0003Ez-Dj
 for kexec@lists.infradead.org; Mon, 19 Dec 2016 07:23:46 +0000
Received: by mail-qk0-f176.google.com with SMTP id q68so6695099qki.1
 for <kexec@lists.infradead.org>; Sun, 18 Dec 2016 23:23:23 -0800 (PST)
Subject: Re: [PATCH V2 1/2] kexec: arm64: create identity page table to be
 used in purgatory
References: <cover.1482129830.git.panand@redhat.com>
 <ea98a0045c8d466456f53150f341546810dd47e1.1482129830.git.panand@redhat.com>
 <CAJGZr0Jg2ptdWGTDczOjdzDx6EkM5mOxWwKckWAZXvA9fzMpUg@mail.gmail.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <c6efdafb-0521-6b9c-4f81-4f455d56be79@redhat.com>
Date: Mon, 19 Dec 2016 12:53:17 +0530
MIME-Version: 1.0
In-Reply-To: <CAJGZr0Jg2ptdWGTDczOjdzDx6EkM5mOxWwKckWAZXvA9fzMpUg@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Maxim Uvarov <muvarov@gmail.com>
Cc: mark.rutland@arm.com, geoff@infradead.org, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, james.morse@arm.com, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org



On Monday 19 December 2016 12:51 PM, Maxim Uvarov wrote:
>> +
>> > +static void craete_block_entry(unsigned long *tbl, unsigned long flags,
> typo in name
>

Thanks.
Will fix.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
