Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WHxo8-000140-Bf
 for kexec@lists.infradead.org; Mon, 24 Feb 2014 15:51:04 +0000
In-Reply-To: <20140224154518.GE4631@redhat.com>
References: <1392888512-4473-1-git-send-email-chaowang@redhat.com>
 <20140224145841.GE1262@dhcp-17-89.nay.redhat.com>
 <20140224152205.GC4631@redhat.com> <1972414.2B2S29ZK0k@skinner>
 <20140224154518.GE4631@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/4] kexec-tools, x86: E820 memmap pass for kdump
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 24 Feb 2014 07:50:19 -0800
Message-ID: <f0e5bc8f-8771-4faa-86a1-a46120a9aa1f@email.android.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, Thomas Renninger <trenn@suse.de>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, jdmason@kudzu.us, dyoung@redhat.com, WANG Chao <chaowang@redhat.com>

Not just SGI, I don't think. You definitely need to do this.

On February 24, 2014 7:45:19 AM PST, Vivek Goyal <vgoyal@redhat.com> wrote:
>On Mon, Feb 24, 2014 at 04:34:26PM +0100, Thomas Renninger wrote:
>
>[..]
>> > > How could this replace saved_max_pfn? The highest memory in kdump
>can't
>> > > necessarily be the real ram size. In kdump, RAM range is just
>part of the
>> > > real ram, not mentioning we don't pass RESERVED range to kdump
>E820.
>> I expected you pass RAM that must not be used as RESERVED. Then,
>still 
>> depending on which mem type is the last one, it might have worked.
>
>No we don't. There is a proposal though to pass first kernel's reserved
>ranges to second kernel as SGI folks need that somehow.
>
>Thanks
>Vivek

-- 
Sent from my mobile phone.  Please pardon brevity and lack of formatting.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
