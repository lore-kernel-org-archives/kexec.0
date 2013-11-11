Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VftxC-0004N2-4c
 for kexec@lists.infradead.org; Mon, 11 Nov 2013 16:03:06 +0000
Message-ID: <5280FF8E.8050801@zytor.com>
Date: Mon, 11 Nov 2013 08:02:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] x86: make reboot task only run on the appropriate
 processor
References: <1383642967-12595-1-git-send-email-bhe@redhat.com>
 <20131108151416.GA13068@redhat.com> <527D0D50.6010607@zytor.com>
 <20131111152948.GA11547@redhat.com>
 <469ce80c-c6a0-4238-aab5-9a4d8c562387@email.android.com>
 <20131111155711.GB11547@redhat.com>
In-Reply-To: <20131111155711.GB11547@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Robin Holt <robinmholt@gmail.com>, Baoquan He <bhe@redhat.com>, mwhitehe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Robin Holt <robinmholt@linux.com>, davej@fedoraproject.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, rmk+kernel@arm.linux.org.uk, tglx@linutronix.de, chaowang@redhat.com

On 11/11/2013 07:57 AM, Vivek Goyal wrote:
> On Mon, Nov 11, 2013 at 07:39:18AM -0800, H. Peter Anvin wrote:
>> Yes, unless there is a better path for it since it is not x86-specific.  I am fine taking it, though.
> 
> Generally Andrew Morton routes kexec/kdump patches through his tree. Andrew,
> do you think it should go through your tree?
> 
> Thanks
> Vivek

If so, you can have my:

Acked-by: H. Peter Anvin <hpa@linux.intel.com>

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
