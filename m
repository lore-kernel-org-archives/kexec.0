Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ce7UP-0006cp-Aq
 for kexec@lists.infradead.org; Wed, 15 Feb 2017 21:51:57 +0000
Received: by mail-qk0-f174.google.com with SMTP id p22so73397705qka.0
 for <kexec@lists.infradead.org>; Wed, 15 Feb 2017 13:51:31 -0800 (PST)
Received: from hops.home (pool-100-0-1-34.bstnma.fios.verizon.net.
 [100.0.1.34])
 by smtp.gmail.com with ESMTPSA id 23sm3121030qtp.20.2017.02.15.13.45.10
 for <kexec@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Feb 2017 13:45:11 -0800 (PST)
Subject: Re: kexec on panic
References: <52a88de81ea3c62bb2be9e222eb85805@nuclearcat.com>
 <20170210164313.5fe98b75@hananiah.suse.cz>
 <864d8c8b-4573-9915-e164-aee5f1dd014b@clifhouck.com>
From: Marc Milgram <mmilgram@redhat.com>
Message-ID: <7455e38d-cdf8-df93-2d8d-027ebf744c51@redhat.com>
Date: Wed, 15 Feb 2017 16:45:10 -0500
MIME-Version: 1.0
In-Reply-To: <864d8c8b-4573-9915-e164-aee5f1dd014b@clifhouck.com>
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
To: kexec@lists.infradead.org

It is possible to boot into a new kernel as documented on the following 
page:

https://access.redhat.com/discussions/682993

That said, even though this is documented on a Red Hat page, Red Hat 
does not officially support it.

Marc

On 02/15/2017 12:29 PM, Clif Houck wrote:
> Is it possible to kexec on demand (not panic!) into another kernel with
> the idea being to avoid a reboot?
>
> For instance, say you had Linux running in a ramdisk, and all that
> ramdisk Linux did was lay down a bootable Linux image onto the main
> disk, and then awaited a command to kexec to the Linux image on disk? Is
> something like that possible? Would I still need to specially craft the
> initrd? If so, is there any literature available on how to do that?
>
> Thanks,
> Clif Houck
>
> On 2/10/2017 9:43 AM, Petr Tesarik wrote:
>> On Fri, 10 Feb 2017 10:14:02 +0200
>> Denys Fedoryshchenko <nuclearcat@nuclearcat.com> wrote:
>>
>>> Hello,
>>>
>>> After years of using kexec and recent unpleasant experience with modern
>>> (supposed to be blazing fast to boot) hardware that need 5-10 minutes
>>> just to pass POST tests,
>>> one question came up to me:
>>> Is it possible anyhow to execute regular (not special "panic" one to
>>> capture crash data) kexec on panic to reduce reboot time?
>>
>> No. But you can load a specially crafted panic initrd which kexec's
>> back to the production kernel.
>>
>> HTH,
>> Petr T
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
