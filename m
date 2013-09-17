Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLqXr-0006pe-A6
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 08:22:03 +0000
Message-ID: <5238110F.9030408@hp.com>
Date: Tue, 17 Sep 2013 16:21:35 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [BUG] [compressed kdump / SADUMP] makedumpfile header truncation
 error
References: <131560856.13730586.1379360704169.JavaMail.root@redhat.com>
 <5237DC38.5020505@hp.com> <5237FCEC.8000608@jp.fujitsu.com>
 <523800C4.6070809@hp.com> <523805C3.5030803@jp.fujitsu.com>
In-Reply-To: <523805C3.5030803@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Baoquan He <bhe@redhat.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, usui@mxm.nes.nec.co.jp, WANG Chao <chaowang@redhat.com>, lisa mitchell <lisa.mitchell@hp.com>, RuiRui Yang <ruyang@redhat.com>, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, Dave Anderson <anderson@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kumagai-atsushi <kumagai-atsushi@mxc.nes.nec.co.jp>, kexec@lists.infradead.org, Jingbai Ma <jingbai.ma@hp.com>, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>

On 09/17/2013 03:33 PM, HATAYAMA Daisuke wrote:
> (2013/09/17 16:12), Jingbai Ma wrote:
>> On 09/17/2013 02:55 PM, HATAYAMA Daisuke wrote:
>>
>> int32_t, int64_t, uint64_t, etc ... are parts of C99 standard:
>> http://en.wikipedia.org/wiki/C_data_types
>> All there types have been supported by GCC, so them should work on all
>> the architectures.
>>
>> Although change these persistent data structure will affect both
>> makedumpfile and crash utility, but we will benefit from the
>> consistent data structures independent from architectures. We can
>> analyze a dumpfile on a OS with different architecture than the
>> crashed OS.
>>
>>
>
> I know stdint.h things and usefulness if we can use crash and makedumpfile
> for a multiple architectures on single arch. In fact, crash already
> supports
> cross platform build among some architectures thanks to Dave.
>
> My question came from the fact that it looks like you introduced a single
> modified kdump_sub_header structure for all the architectures. They might
> have different combination of length between int and long and maybe
> also have other each architecture specific incompatibility. It wouldn't
> work well.
>
> But from your reply, I think you mean a fully new header for
> kdump-compressed
> format, right? If so, it must work well. But of course you need to modify
> both of makedumpfile and crash utility to support it.
>

Yes, I would like to have a new header for kdump-compressed format. But 
I'm not sure how much code will be affected in makedumpfile and crash 
utility.
I'm still under investigating, any ideas would be appreciated.


-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
