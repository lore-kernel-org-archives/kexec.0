Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VgjBb-0007G4-3v
 for kexec@lists.infradead.org; Wed, 13 Nov 2013 22:45:23 +0000
Message-ID: <528400DD.3040003@zytor.com>
Date: Wed, 13 Nov 2013 14:44:45 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: /proc/vmcore mmap() failure issue
References: <20131113204130.GD7613@redhat.com>
 <20131113210432.GE7613@redhat.com> <5283EBCD.6070305@zytor.com>
 <20131113224104.GF7613@redhat.com>
In-Reply-To: <20131113224104.GF7613@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>

On 11/13/2013 02:41 PM, Vivek Goyal wrote:
> 
> Hi Peter,
> 
> I noticed we seem to be trimming away partial pages in memblock.
> 
> memblock_x86_fill() {
> 	/* throw away partial pages */
>         memblock_trim_memory(PAGE_SIZE);
> }
> 
> But not in e820 hence they show up in /proc/iomem.
> 

Why does /proc/iomem matter?

> How about something along the lines as below patch. This fixes my
> /proc/vmcore mmap() issue.

I'm not sure if what you're seeing is something that is better handled
in userspace.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
