Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W5RVA-0001OD-3i
 for kexec@lists.infradead.org; Tue, 21 Jan 2014 02:55:45 +0000
Date: Tue, 21 Jan 2014 10:55:36 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 0/4] kexec-tools: efi runtime support on kexec kernel
Message-ID: <20140121025536.GA5544@dhcp-16-126.nay.redhat.com>
References: <1387533947-18210-1-git-send-email-dyoung@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1387533947-18210-1-git-send-email-dyoung@redhat.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

Hi, Simon

The kernel patches has been merged into Linus tree, could you take a look
at these kexec-tools patches and merge them if there's no more comments?

Patch 4/4 was resended in a reply to original 4/4, the subject is:
[PATCH v4 4/4 update] Passing efi related data via setup_data
These patches has been tested by Toshi Kani <toshi.kani@hp.com>

If you need I resend them please let me know.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
