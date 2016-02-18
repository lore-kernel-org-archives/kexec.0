Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2on0146.outbound.protection.outlook.com
 ([207.46.100.146] helo=na01-by2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aWWnX-0008Ff-Ed
 for kexec@lists.infradead.org; Thu, 18 Feb 2016 22:11:44 +0000
Subject: Re: makedumpfile: 4.5 kernel commit breaks page filtering
References: <649995246.30033929.1455815111557.JavaMail.zimbra@redhat.com>
 <993568633.14672711.1455817238002.JavaMail.zimbra@redhat.com>
From: Joe Lawrence <joe.lawrence@stratus.com>
Message-ID: <56C64183.7060407@stratus.com>
Date: Thu, 18 Feb 2016 17:11:15 -0500
MIME-Version: 1.0
In-Reply-To: <993568633.14672711.1455817238002.JavaMail.zimbra@redhat.com>
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
To: Laurence Oberman <loberman@redhat.com>, Dave Anderson <anderson@redhat.com>
Cc: ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, "Discussion list
 for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>

On 02/18/2016 12:40 PM, Laurence Oberman wrote:
> Dave, I confirmed that if I use -d17 for makedumpfile I can then capture a usable core.
> I am on 4.5.0-0.rc3.git3.1
> Thanks
> Laurence

FWIW I can confirm successful capture andread of vmcore on 4.5.0-rc4
when filtering with -d17.

-- Joe

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
