Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDmNC-0004EW-W6
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 01:45:29 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 573E73EE0BC
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:45:24 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4092145DE56
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:45:24 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1F92545DE58
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:45:24 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1386A1DB804B
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:45:24 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id BE55D1DB804D
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:45:23 +0900 (JST)
Date: Fri, 08 Mar 2013 10:45:18 +0900 (JST)
Message-Id: <20130308.104518.339920543.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC] makedumpfile: Improve reading speed with mmap()
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130306.181349.528423566.d.hatayama@jp.fujitsu.com>
References: <20130306154804.00650801c5973637e6a5c82d@mxc.nes.nec.co.jp>
 <20130306.181349.528423566.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, cpw@sgi.com, lisa.mitchell@hp.com, vgoyal@redhat.com

From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC] makedumpfile: Improve reading speed with mmap()
Date: Wed, 6 Mar 2013 18:13:50 +0900

> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Subject: [RFC] makedumpfile: Improve reading speed with mmap()
> Date: Wed, 6 Mar 2013 15:48:04 +0900
> 
>> Hello,
>> 
>> I made the prototype patch to use mmap() on /proc/vmcore for
>> benchmarking.
>> 
>> This patch simply replaces read(2) with mmap(2), I think we can see
>> the pure performance improvement by reducing the number of map/unmap.
>> 
>>   - When /proc/vmcore supports mmap(), readmem() calls read_with_mmap() 
>>     to read /proc/vmcore with mmap() instead of read().
>> 
>>   - Introduce --map-size <Kbyte> option to specify the map size.
>>     This option is necessary to use mmap() in this patch, but just for
>>     benchmarking. I'll remove this option in release version and change
>>     the map size into suitable constant size to get enough performance
>>     improvement.
>> 
>>   - This patch is based on devel branch:
>>     http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=shortlog;h=refs/heads/devel
>> 
>> Unfortunately, I haven't done test and benchmarking in 2nd kernel yet
>> because I can't start up newer kernel as 2nd kernel on my machine.
>> (It seems just my environment issue.) 
>> 
>> At least, this patch works for vmcores saved on local disk,
>> so it will work in 2nd kernel too.
>> 
>> If anyone helps to do benchmarking, it's very helpful for me.
>> And any comments for this patch are welcome.
> 
> Kumagai-san,
> 
> I think it necessary to compare this generic one with the idea
> considering virtual memory mapping, which should affect filtering
> performance to some degree.
> 
> http://lists.infradead.org/pipermail/kexec/2013-February/007982.html
> 
> I guess implementation can relatively be moduler. I'll post a
> prorotype patch for benchmark later.

Sorry, I investigated this around again and now I think this generic
one is enough if size of mmap() range is large enough more than 2MB
that is page size used for mapping virtual memory mapping.

So, let's benchmark this version.

BTW, I think it useful to prepare a temporary branch for this
benchmark for people who help benchmark. It's awkward to manage
patches manually.

Also, I posted the following patch yesterday. The v2 patch for mmap()
on /proc/vmcore needs this since new note type is added in
"VMCOREINFO" name.

[PATCH 0/3] makedumpfile, elf: distinguish ELF note types by ELF note names
http://lists.infradead.org/pipermail/kexec/2013-March/008136.html

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
