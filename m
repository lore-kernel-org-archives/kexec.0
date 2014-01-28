Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W8Das-00053b-3D
 for kexec@lists.infradead.org; Tue, 28 Jan 2014 18:41:07 +0000
Date: Tue, 28 Jan 2014 13:40:42 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: More frequent kexec-tools releases
Message-ID: <20140128184042.GA7098@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Kexec Mailing List <kexec@lists.infradead.org>
Cc: Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>

Hi All,

Just now we were discussing that fedora kexec-tools should rebase to
upstream kexec-tools every release so that we can test the latest code
sooner.

Then Dave Young pulled in some data about the kexec-tools release
duration.

Date:   Tue Mar 19 10:46:46 2013 +0900
    kexec-tools 2.0.4 ~100 commits

Date:   Mon Jan 16 09:15:25 2012 +1100
    kexec-tools 2.0.3 ~100 commits

Date:   Thu Jul 29 13:40:00 2010 +0900
    kexec-tools 2.0.2 ~80 commits

Date:   Thu Aug 13 09:28:08 2009 +1000
    kexec-tools 2.0.1 ~60 commits

Date:   Sat Jul 19 10:31:30 2008 +1000
    kexec-tools 2.0.0

So that is 5 release in 5.5 years. It is roughly 1 release per year.

I am wondering if there is any interest in more frequent releases of
kexec-tools. Say every 3 months or every 6 months.

IMHO, it might be better if there are more frequent release of kexec-tools
(say a release every 6 months) and then every 6 months distributions
should be able to rebase to that new release.

Thoughts?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
