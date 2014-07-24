Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XARB5-0008Jz-OK
 for kexec@lists.infradead.org; Thu, 24 Jul 2014 22:07:56 +0000
Date: Thu, 24 Jul 2014 15:07:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1] kexec: Verify the signature of signed PE bzImage
Message-Id: <20140724150730.7827985aa003a236e2140a6b@linux-foundation.org>
In-Reply-To: <20140724141642.GI8573@redhat.com>
References: <1404930247-7546-1-git-send-email-vgoyal@redhat.com>
 <1404930247-7546-2-git-send-email-vgoyal@redhat.com>
 <20140724141642.GI8573@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com

On Thu, 24 Jul 2014 10:16:42 -0400 Vivek Goyal <vgoyal@redhat.com> wrote:

> I am wondering how this final kexec patch should be routed. Issue here is that
> this patch depends on David Howells's PKCS7 and PEFILE patches. Which are now
> sitting in security tree. (security/next).
> 
> http://git.kernel.org/cgit/linux/kernel/git/jmorris/linux-security.git/log/?h=next
> 
> Not sure how to handle this dependency issue.

I have all these patches staged after linux-next so it fitted
straight in.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
