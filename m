Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vjsbg-00017K-W2
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 15:25:22 +0000
Message-ID: <528F7735.9010209@zytor.com>
Date: Fri, 22 Nov 2013 07:24:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 5/6] kexec-bzImage: Support for loading bzImage using
 64bit entry
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-6-git-send-email-vgoyal@redhat.com>
 <20131121190710.GD17070@kroah.com> <20131121192114.GN16208@redhat.com>
In-Reply-To: <20131121192114.GN16208@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, Greg KH <greg@kroah.com>
Cc: mjg59@srcf.ucam.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com

On 11/21/2013 11:21 AM, Vivek Goyal wrote:
>>
>> What do you mean by the "real mode entry"?  Do we need to care about
>> that because we aren't falling back to real mode when executing this,
>> are we?  Or does that just happen for 32bit kernels?
> 
> Original kexec offers real mode entry choice too. So we fall back
> to real mode and jump to kernel and kernel makes bunch of BIOS calls. I
> don't think this is a commonly used option.
> 

I know some users of it (who I shall not name.)  In general it is a bad
option, because after running the first kernel the state of the hardware
is not guaranteed to be such that executing the BIOS is safe.  In
general, I do think they do it just because they tried at some point and
it happened to work; discouraging its use is probably for the better.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
