Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [162.243.103.125] (helo=houck.info)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ce3Ol-00024l-Bj
 for kexec@lists.infradead.org; Wed, 15 Feb 2017 17:29:50 +0000
Subject: Re: kexec on panic
References: <52a88de81ea3c62bb2be9e222eb85805@nuclearcat.com>
 <20170210164313.5fe98b75@hananiah.suse.cz>
From: Clif Houck <me@clifhouck.com>
Message-ID: <864d8c8b-4573-9915-e164-aee5f1dd014b@clifhouck.com>
Date: Wed, 15 Feb 2017 11:29:32 -0600
MIME-Version: 1.0
In-Reply-To: <20170210164313.5fe98b75@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org

Is it possible to kexec on demand (not panic!) into another kernel with
the idea being to avoid a reboot?

For instance, say you had Linux running in a ramdisk, and all that
ramdisk Linux did was lay down a bootable Linux image onto the main
disk, and then awaited a command to kexec to the Linux image on disk? Is
something like that possible? Would I still need to specially craft the
initrd? If so, is there any literature available on how to do that?

Thanks,
Clif Houck

On 2/10/2017 9:43 AM, Petr Tesarik wrote:
> On Fri, 10 Feb 2017 10:14:02 +0200
> Denys Fedoryshchenko <nuclearcat@nuclearcat.com> wrote:
> 
>> Hello,
>>
>> After years of using kexec and recent unpleasant experience with modern 
>> (supposed to be blazing fast to boot) hardware that need 5-10 minutes 
>> just to pass POST tests,
>> one question came up to me:
>> Is it possible anyhow to execute regular (not special "panic" one to 
>> capture crash data) kexec on panic to reduce reboot time?
> 
> No. But you can load a specially crafted panic initrd which kexec's
> back to the production kernel.
> 
> HTH,
> Petr T
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
