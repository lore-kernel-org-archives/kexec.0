Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U7TJ7-0007ap-9D
 for kexec@lists.infradead.org; Mon, 18 Feb 2013 16:11:10 +0000
Date: Tue, 19 Feb 2013 01:11:05 +0900 (JST)
Message-Id: <20130219.011105.197738964.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 05/13] vmcore: modify ELF32 code according to new type
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130215153048.GD27784@redhat.com>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
 <20130214101210.22466.36330.stgit@localhost6.localdomain6>
 <20130215153048.GD27784@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, cpw@sgi.com

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 05/13] vmcore: modify ELF32 code according to new type
Date: Fri, 15 Feb 2013 10:30:48 -0500

> On Thu, Feb 14, 2013 at 07:12:10PM +0900, HATAYAMA Daisuke wrote:
>> On elf32 mmap() is not supported. All vmcore objects are in old
>> memory.
> 
> This is odd. Why can't we support mmap() when 32bit headers have been
> prepared?
> 
> Thanks
> Vivek
> 

I didin't think there's much usecase on ELF32 interface as I wrote in
the last patch description, but OK, I'll implement it on 32-bit
interface too.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
