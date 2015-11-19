Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZzI3w-00014i-No
 for kexec@lists.infradead.org; Thu, 19 Nov 2015 05:47:17 +0000
Received: by wmvv187 with SMTP id v187so8454767wmv.1
 for <kexec@lists.infradead.org>; Wed, 18 Nov 2015 21:46:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151119025323.GA6022@dhcp-128-65.nay.redhat.com>
References: <CA+MhoaMjeVODU_zt=8OoU4zAzBt6hA219=44kee+FR3Ew_v3Vw@mail.gmail.com>
 <20151119025323.GA6022@dhcp-128-65.nay.redhat.com>
Date: Thu, 19 Nov 2015 13:46:54 +0800
Message-ID: <CA+MhoaNy+Orq97Sb1V6NOHJ4SOgpM38MiXyqdSnLFKT-85rLXg@mail.gmail.com>
Subject: Re: How to understand "high" or "low" in crashkernel configuration?
From: Nan Xiao <xiaonan830818@gmail.com>
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
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

Hi Dave,

Got it, thanks very much!
Best Regards
Nan Xiao


On Thu, Nov 19, 2015 at 10:53 AM, Dave Young <dyoung@redhat.com> wrote:
> On 11/18/15 at 10:45pm, Nan Xiao wrote:
>> Hi all,
>>
>> When I use SuSE default Kdump configuration, I find there is "high" or "low" in
>> crashkernel's value, and it likes this:
>>
>>     crashkernel=xxM,high Or crashkernel=xxM,low
>>
>> But from this document(https://www.kernel.org/doc/Documentation/kdump/kdump.txt),
>> I can't find explanation of "high" or "low". How to understand it?
>
> You can find it in Documentation/kernel-parameters.txt
>
>
>>
>> Thanks very much in advance!
>>
>> Best Regards
>> Nan Xiao
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
