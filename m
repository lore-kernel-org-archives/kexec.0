Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail5.windriver.com ([192.103.53.11] helo=mail5.wrs.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNKMm-0006dt-Bu
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 13:38:24 +0000
Message-ID: <57864438.9020103@windriver.com>
Date: Wed, 13 Jul 2016 21:38:00 +0800
From: Lans Zhang <jia.zhang@windriver.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] pefile: Fix the failure of calculation for digest
References: <1468399874-5880-2-git-send-email-jia.zhang@windriver.com>
 <1468399874-5880-1-git-send-email-jia.zhang@windriver.com>
 <4333.1468415184@warthog.procyon.org.uk>
In-Reply-To: <4333.1468415184@warthog.procyon.org.uk>
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
To: David Howells <dhowells@redhat.com>
Cc: kexec@lists.infradead.org, vgoyal@redhat.com, bhe@redhat.com

Thanks for your review. I will send V2 soon.

Jia

On 07/13/2016 09:06 PM, David Howells wrote:
> Lans Zhang<jia.zhang@windriver.com>  wrote:
>
>> The commit e68503bd forgot to set digest_len and thus cause the following
>> error reported by kexec when launching a crash kernel:
>> "kexec_file_load failed: Bad message"
>
> You need to put the commit ID in a "Fixes:" line as per SubmittingPatches.
>
> David
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
