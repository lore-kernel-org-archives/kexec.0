Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([2a00:1098:0:80:1000:c:0:1])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vlkk9-0007tV-Em
 for kexec@lists.infradead.org; Wed, 27 Nov 2013 19:25:50 +0000
Date: Wed, 27 Nov 2013 19:24:20 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] PCI: Clear Bus Master bit only on kexec reboot
Message-ID: <20131127192420.GC11829@srcf.ucam.org>
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
Cc: cl91tp@gmail.com, gnomes@lxorguk.ukuu.org.uk, indou.takao@jp.fujitsu.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, f.otti@gmx.at, khlebnikov@openvz.org, ebiederm@xmission.com, jility09@gmail.com, bhelgaas@google.com, tianyu.lan@intel.com

On Wed, Nov 27, 2013 at 12:18:28PM -0700, Khalid Aziz wrote:

> +/* flag to track if kexec reboot is in progress */
> +extern unsigned long kexec_in_progress;

Adding this to pci.h seems a little odd. We may want to use it somewhere 
else at some point. Add it to kexec.h instead?

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
