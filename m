Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vlkx0-0008BJ-6R
 for kexec@lists.infradead.org; Wed, 27 Nov 2013 19:39:06 +0000
Date: Wed, 27 Nov 2013 11:39:32 -0800
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: Clear Bus Master bit only on kexec reboot
Message-ID: <20131127193932.GA16431@kroah.com>
References: <1385579908-24608-1-git-send-email-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385579908-24608-1-git-send-email-khalid.aziz@oracle.com>
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
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: cl91tp@gmail.com, gnomes@lxorguk.ukuu.org.uk, indou.takao@jp.fujitsu.com, mjg59@srcf.ucam.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, f.otti@gmx.at, khlebnikov@openvz.org, ebiederm@xmission.com, jility09@gmail.com, bhelgaas@google.com, tianyu.lan@intel.com

On Wed, Nov 27, 2013 at 12:18:28PM -0700, Khalid Aziz wrote:
> +/* flag to track if kexec reboot is in progress */
> +extern unsigned long kexec_in_progress;

"unsigned long" for a "flag"?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
