Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZS1GX-0003l1-GV
 for kexec@lists.infradead.org; Wed, 19 Aug 2015 11:10:46 +0000
Received: by wicne3 with SMTP id ne3so123752134wic.1
 for <kexec@lists.infradead.org>; Wed, 19 Aug 2015 04:10:22 -0700 (PDT)
Subject: Re: Dmesg not being dumped
References: <55D42056.5070709@kyup.com>
 <20150819090202.GF19950@dhcp-128-28.nay.redhat.com>
From: Nikolay Borisov <kernel@kyup.com>
Message-ID: <55D4641D.70902@kyup.com>
Date: Wed, 19 Aug 2015 14:10:21 +0300
MIME-Version: 1.0
In-Reply-To: <20150819090202.GF19950@dhcp-128-28.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org

Hi,

On 08/19/2015 12:02 PM, Baoquan He wrote:
> On 08/19/15 at 09:21am, Nikolay Borisov wrote:
>> Hello,
>>
>> I've recently noticed that when creating crashdumps the dmesg is not
>> being saved. The error reported is this: "Missing the struct log size
>> export". I've tested with both kernel 4.1.1 and 3.12.28. My version of
>> kexec tools is : kexec-tools 2.0.9 released 04 June 2015. The kernel has
>> been compiled with debugging info so the respective symbol should be
>> exported but apparently it is not. Any ideas how to debug that?
> 
> That would be more helpful if you can attach the 1st kernel and kdump
> kernel console log.

I just tested with 4.1.6 with the same result. I'm sending you a link to
the bzImage in question
http://georgi.unixsol.org/cruft/tmp/bzImage-4.1.6-clouder1 ( I assume
you meant the bzImage, if you need I can provide the vmlinux as well).
Unfortunately, I couldn't figure how to obtain the log of kdump in
textual format (and didn't want to send pictures). Here are the 3
relevant lines (from memory):

Saving vmcore-dmesg.txt
Missing the struct log size export
Error saving vmcore-dmesg.txt.

Yet, when I load the crashdump inside the 'crash' utility and invoke the
'log' command the dmesg log is there. Whereas the
vmcore-dmesg-incomplete.txt is empty.


> 
>>
>> [Please CC me as I'm not subscribed to the mailing list.]
>>
>> Regards,
>> Nikolay
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
