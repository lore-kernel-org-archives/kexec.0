Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQfOw-0005yR-Jm
 for kexec@lists.infradead.org; Fri, 12 Apr 2013 14:56:31 +0000
Message-ID: <5168208B.7050107@zytor.com>
Date: Fri, 12 Apr 2013 07:56:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] kexec: X86: Pass memory ranges via e820 table instead
 of memmap= boot parameter
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
 <1365683207-42425-6-git-send-email-trenn@suse.de>
 <CAE9FiQXnZzVC7dtvXWrqz=jYAGH053R8Vw1qkrMd2F+hAaMxdQ@mail.gmail.com>
 <5166D18A.7090800@zytor.com> <20130412143104.GA4301@redhat.com>
In-Reply-To: <20130412143104.GA4301@redhat.com>
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
Cc: Dave Hansen <dave@sr71.net>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Renninger <trenn@suse.de>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Yinghai Lu <yinghai@kernel.org>, Cliff Wickman <cpw@sgi.com>

On 04/12/2013 07:31 AM, Vivek Goyal wrote:
>>
>> I also have to admit that I don't see the difference between /dev/mem
>> and /dev/oldmem, as the former allows access to memory ranges outside
>> the ones used by the current kernel, which is what the oldmem device
>> seems to be intended to od.
> 
> I think one difference seems to be that /dev/mem assumes that validly
> accessed memory is already mapped in kernel while /dev/oldmeme assumes
> it is not mapped and creates temporary mappings explicitly.
> 

Dave Hansen has been working on fixing /dev/mem for HIGHMEM.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
