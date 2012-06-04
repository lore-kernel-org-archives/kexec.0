Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SbeLQ-0007Z7-4F
 for kexec@lists.infradead.org; Mon, 04 Jun 2012 20:57:44 +0000
Received: from whiskey.americas.sgi.com (whiskey.americas.sgi.com
 [128.162.233.19])
 by relay1.corp.sgi.com (Postfix) with ESMTP id 95D068F8054
 for <kexec@lists.infradead.org>; Mon,  4 Jun 2012 13:57:39 -0700 (PDT)
Date: Mon, 4 Jun 2012 16:04:00 -0500
From: Ben Myers <bpm@sgi.com>
Subject: kdump on linux v3.5-rc1
Message-ID: <20120604210400.GM4721@sgi.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi Folks,

I'm updating to a 3.5-rc1 based kernel and I have noticed that now kdump
is no longer working.  The symptom is that when I

'echo c > /proc/sysrq-trigger'

I do crash the machine, but then nothing happens...  i.e. the dump
kernel never kicks off.  Initially I was using kdump version 0.7.8, but
now I have upgaded to 0.8.1-13.1.3, building from the open suse source
rpm (on sles11sp1). 

Does this ring any bells for you?  I'd appreciate any assistance you can
provide.   

Thanks,
Ben

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
