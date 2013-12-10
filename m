Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqWgu-0001Ev-Jx
 for kexec@lists.infradead.org; Tue, 10 Dec 2013 23:26:12 +0000
Date: Tue, 10 Dec 2013 15:25:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 00/14] kexec kernel efi runtime support
Message-Id: <20131210152549.7975e3ac25d854e2ada63221@linux-foundation.org>
In-Reply-To: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Mon,  9 Dec 2013 17:42:13 +0800 Dave Young <dyoung@redhat.com> wrote:

> Here is the V5 patchset for supporting kexec kernel efi runtime.

It's unclear (to me) who's supposed to merge this lot.  It's a "kexec"
patch which actually hits on efi and x86.

I grabbed them for some -next testing but won't be offended if someone
else merges them ;)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
