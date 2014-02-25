Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIMuB-0003Ol-Qx
 for kexec@lists.infradead.org; Tue, 25 Feb 2014 18:39:00 +0000
Message-ID: <530CE320.6000808@zytor.com>
Date: Tue, 25 Feb 2014 10:38:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 08/11] kexec-bzImage: Support for loading bzImage using
 64bit entry
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-9-git-send-email-vgoyal@redhat.com>
In-Reply-To: <1390849071-21989-9-git-send-email-vgoyal@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, jkosina@suse.cz, ebiederm@xmission.com, greg@kroah.com

On 01/27/2014 10:57 AM, Vivek Goyal wrote:
> This is loader specific code which can load bzImage and set it up for
> 64bit entry. This does not take care of 32bit entry or real mode entry
> yet.

Is there any use in that?  Real mode entry especially is more than a bit
scary when coming from another kernel already...

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
