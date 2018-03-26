Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f0TgI-0000Po-R9
 for kexec@lists.infradead.org; Mon, 26 Mar 2018 15:05:09 +0000
Received: by mail-pl0-x241.google.com with SMTP id x4-v6so12093843pln.7
 for <kexec@lists.infradead.org>; Mon, 26 Mar 2018 08:04:56 -0700 (PDT)
Date: Mon, 26 Mar 2018 23:04:47 +0800
From: Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH 1/2] resource: add walk_system_ram_res_rev()
Message-ID: <20180326150447.GA78252@WeideMacBook-Pro.local>
References: <20180322033722.9279-1-bhe@redhat.com>
 <20180322033722.9279-2-bhe@redhat.com>
 <20180322152929.9b421af2f66cc819ad691207@linux-foundation.org>
 <20180323005845.GA25740@localhost.localdomain>
 <20180322190606.859a0f1c7e2d1b2958daeb9f@linux-foundation.org>
 <20180323031013.GB11150@localhost.localdomain>
 <20180323130620.7d60fc442463ed5c21898387@linux-foundation.org>
 <20180324133330.GD25740@localhost.localdomain>
 <20180324161343.GA58414@WeideMacBook-Pro.local>
 <20180326143016.GE25740@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180326143016.GE25740@localhost.localdomain>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: prudo@linux.vnet.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>, takahiro.akashi@linaro.org, ebiederm@xmission.com, Andrew Morton <akpm@linux-foundation.org>, dyoung@redhat.com, vgoyal@redhat.com

On Mon, Mar 26, 2018 at 10:30:16PM +0800, Baoquan He wrote:
>Hi Wei Yang,
>
>On 03/25/18 at 12:13am, Wei Yang wrote:
>> On Sat, Mar 24, 2018 at 09:33:30PM +0800, Baoquan He wrote:
>> >> 
>> >> Yes.  That sounds perfectly acceptable.
>> >> 
>> >> It would be interesting to see what this approach looks like, if you
>> >> have time to toss something together?
>> >
>> >OK, will make patches for reviewing. Thanks!
>> 
>> Hi, Baoquan, Andrew
>> 
>> I have come up with an implementation for top-down search the ram resources.
>> Hope this would meet your need.
>
>Thanks for telling and your effort. Glad to know
>I am not the only buyer of walk_system_ram_res_rev. I am fine with other
>ways to make it, people can compare them and know which one is better.
>I am working to use the list_head instead, the doubly linked list way
>as Andrew suggested. Andrew and other people can help make a choice. It
>won't be long.
>

Sure,

Look forward your approach.

>Thanks
>Baoquan
>

-- 
Wei Yang
Help you, Help me

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
